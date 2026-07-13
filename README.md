# EKS Karpenter Terraform

A production-style Amazon EKS platform, built end-to-end with Terraform, Karpenter, Kubernetes, Helm, GitHub Actions, Amazon ECR, ArgoCD, and AWS-native observability.

This isn't a collection of unrelated examples — it's one connected platform. Terraform builds the AWS foundation and hands out identity to every controller and workload. Kubernetes add-ons and two sample microservices consume that identity to actually do useful work (route traffic, read secrets, mount volumes, scale nodes). GitHub Actions and ArgoCD move code from a `git push` to a running pod. Observability watches all of it. The sections below walk through that chain so you can see how a single line in Terraform ends up as a metric in Grafana.

## The Core Idea: Everything Is Wired Through IAM

The single thread that ties this whole repo together is **EKS Pod Identity**. Instead of every controller (Karpenter, the Load Balancer Controller, the EBS CSI Driver, ADOT, the payments microservice) having its own bespoke way of getting AWS credentials, every one of them follows the exact same pattern in Terraform:

1. An IAM role is created with a trust policy that trusts `pods.eks.amazonaws.com`.
2. An IAM policy is attached to that role, scoped to exactly what that component needs (e.g. Karpenter gets `ec2:CreateFleet`/`ec2:RunInstances`, the payments IAM module gets `secretsmanager:GetSecretValue`, ADOT gets `aps:RemoteWrite`).
3. An `aws_eks_pod_identity_association` links that role to a specific **namespace + service account** in the cluster.

That third step is the join point between the Terraform layer and the Kubernetes layer. Terraform never touches a Kubernetes manifest, and Kubernetes manifests never contain an AWS access key — the association is the only thing connecting them. So when you're reading this repo, the mental model for every component is the same: *find the Terraform role, find the pod identity association, then go find the matching service account in `kubernetes/` that the role was bound to.*

This is also why `terraform/modules/eks/main.tf` tags the cluster's security group with `karpenter.sh/discovery`, and why the VPC's private subnets carry the same tag — Karpenter's `EC2NodeClass` (in `kubernetes/karpenter/ec2nodeclass.yaml`) doesn't hardcode a subnet ID, it discovers the right subnets and security groups at runtime by matching that tag. Terraform plants the tags; Karpenter reads them.

## Layer 1: Terraform — The Foundation

The Terraform root module (`terraform/main.tf`) wires together modules in this order:

- **`modules/vpc`** — private and public subnets, tagged for Karpenter discovery.
- **`modules/eks`** — the EKS control plane itself, plus the `eks-pod-identity-agent` add-on. This add-on is what makes every Pod Identity association elsewhere in the platform actually work at runtime — without it, none of the role bindings below would resolve to real credentials.
- **`modules/karpenter`** — two IAM roles: one for the Karpenter *controller* (permissions to call EC2 and EKS APIs to create/destroy nodes) and one for the *nodes themselves* (the standard worker-node/CNI/ECR/SSM policies EC2 instances need once they join the cluster). It also provisions an SQS queue plus four EventBridge rules (Spot interruption, rebalance recommendation, instance state change, scheduled maintenance) — this is the mechanism behind graceful Spot handling: AWS emits an event, EventBridge routes it to SQS, and the Node Termination Handler (deployed via Helm in `kubernetes/node-termination-handler/`) drains the node before it disappears.
- **`modules/platform-addons`** — IAM + EKS add-ons for the EBS CSI Driver and the AWS Secrets Store CSI Provider, IAM for the AWS Load Balancer Controller, and the two ECR repositories (`payments-microservice`, `orders-microservice`) with a 10-image lifecycle policy so ECR doesn't grow unbounded.
- **`modules/workload-iam`** — a *reusable* module, not a one-off. It's called once in the root (`payments_workload_iam`) to create a scoped IAM role that can only read the specific Secrets Manager ARNs passed into it, and binds it to the `payments` namespace / `payments-microservice` service account. If you added a third microservice that needed its own secrets, you'd call this same module again with different inputs rather than writing new IAM from scratch.
- **`modules/github-oidc`** — an OIDC identity provider trusting `token.actions.githubusercontent.com`, plus a role GitHub Actions can assume — scoped by a `sub` condition to *this specific repo* — with permission to push only to the two ECR repos above. This is what lets CI authenticate to AWS with zero long-lived secrets.
- **`modules/observability`** — an Amazon Managed Prometheus (AMP) workspace, an IAM role for the ADOT collector to remote-write metrics into it, an Amazon Managed Grafana workspace, and an IAM role letting Grafana query AMP. Terraform's outputs (`amp_remote_write_endpoint`, etc.) are the values that get substituted into the ADOT collector config at deploy time.

Every module's outputs bubble up to the root `outputs.tf`, which is effectively the "contract" the Kubernetes/Helm layer depends on: role ARNs, the AMP endpoint, ECR URLs, the GitHub Actions role ARN. Nothing below this layer invents its own AWS permissions — it all traces back to one of these outputs.

## Layer 2: Kubernetes — Where Terraform's Identities Get Used

### Karpenter: elastic node capacity

`kubernetes/karpenter/nodepool.yaml` and `ec2nodeclass.yaml` are the two CRDs that actually drive autoscaling. The `NodePool` defines *what* can be provisioned (architecture, OS, Spot vs on-demand, an instance type shortlist, a 100-vCPU ceiling) and *when nodes get removed* (`consolidateAfter: 30s` — Karpenter actively consolidates underused nodes rather than waiting for a fixed bin-packing interval). The `EC2NodeClass` defines *how* — which AMI family, which IAM node role (the one Terraform created), and the subnet/security-group discovery tags mentioned above. When a pod can't be scheduled, Karpenter (running under the controller IAM role from Terraform) reads these two objects, calls `ec2:CreateFleet`, and a node appears — no manually-sized node group required.

### The Load Balancer Controller and Secrets/EBS CSI drivers

These are the "plumbing" add-ons: the AWS Load Balancer Controller turns Kubernetes `Ingress` objects into real ALBs, the Secrets Store CSI Driver + AWS provider turns a `SecretProviderClass` into files (and optionally Kubernetes `Secret` objects) sourced from Secrets Manager, and the EBS CSI Driver turns a `StorageClass`/`PersistentVolumeClaim` into an actual EBS volume. All three run under the Pod Identity roles Terraform created in `platform-addons` — they're installed via Helm (see each folder's `values-dev.yaml` / `values-prod.yaml`) but their AWS permissions come entirely from Terraform.

### Payments microservice — the "secrets + traffic" example

This service exists to demonstrate the full secrets-and-ingress path in one place:

- `serviceaccount.yaml` creates `payments-microservice` in the `payments` namespace — the exact name/namespace pair that `workload-iam`'s Pod Identity association in Terraform is bound to. This is the literal connection between the IAM role and the pod.
- `secretproviderclass.yaml` tells the Secrets Store CSI Driver which Secrets Manager secret to fetch and how to map its JSON fields (`DB_USERNAME`, `DB_PASSWORD`) into mountable/consumable values.
- `deployment.yaml` mounts that `SecretProviderClass` as a CSI volume *and* consumes the same values as environment variables via a mirrored Kubernetes `Secret` — showing both consumption patterns side by side. It also references a `ConfigMap` for non-secret config and a `PriorityClass` (`payments-high-priority`) so this workload gets scheduling priority over lower-tier pods when a node is under pressure.
- `hpa.yaml` scales the Deployment on CPU utilization, `pdb.yaml`/`networkpolicy.yaml`/`resourcequota.yaml`/`limitrange.yaml` round out the "this is how you'd actually run it" governance layer.
- `ingress.yaml` is what the Load Balancer Controller turns into a real ALB listener routing to this service.

### Orders microservice — the "persistent storage" example

Where payments demonstrates secrets and traffic, orders demonstrates state: `storageclass.yaml` defines an EBS-backed class (`WaitForFirstConsumer`, encrypted, expandable), `pvc.yaml` requests a volume against it, and `deployment.yaml` mounts that PVC at `/app/data`. The EBS CSI Driver (again, running under its Terraform-created role) is what turns that PVC into a real, attached volume the moment a pod using it gets scheduled onto a node.

### Observability: closing the loop

`kubernetes/observability/adot-collector/collector-dev.yaml` is an `OpenTelemetryCollector` that scrapes Kubernetes nodes/pods plus `kube-state-metrics` and `prometheus-node-exporter`, batches the results, and remote-writes them to AMP using `sigv4auth` — SigV4 signing is only possible because this collector's service account (`adot-collector`) is bound, via Pod Identity, to the `aws_iam_role.adot_collector` role Terraform created with exactly the `aps:RemoteWrite` permission it needs. Amazon Managed Grafana then queries that same AMP workspace to visualize it, using its own Terraform-created role. Nothing here uses a hardcoded AWS credential anywhere.

## Layer 3: CI/CD — From `git push` to a Running Pod

Two independent GitHub Actions pipelines, split by concern so an app change and an infrastructure change never block each other:

**`.github/workflows/ci-ecr-build.yaml`** triggers on changes under `app/payments-microservice/**` or `app/orders-microservice/**`. It assumes the GitHub OIDC role Terraform created (no static AWS keys stored in GitHub), builds and pushes both Docker images to their ECR repos tagged with the commit SHA, then rewrites the `tag:` field in each service's `values-dev.yaml` and commits that change straight back to the repo.

**`.github/workflows/terraform-infra.yaml`** triggers on changes under `Terraform/**`: `terraform fmt`, `init`, `validate`, and `plan` run on every PR; `apply` runs automatically only on a push to `main`, gated behind a GitHub Environment (`production`) for an approval step.

The connective tissue between these two pipelines and the cluster is **ArgoCD**, not a `kubectl apply` step in CI. CI's only job is to update a values file and push that commit — it never touches the cluster directly.

## Layer 4: ArgoCD — GitOps Is What Actually Deploys

`kubernetes/argocd/application-project.yaml` defines an `AppProject` scoping which repo, namespaces, and resource kinds ArgoCD is allowed to manage. `applicationset.yaml` is the piece that ties the two microservices together generically: rather than one hand-written `Application` per service, an `ApplicationSet` with a `list` generator iterates over `{payments-microservice, orders-microservice}` and stamps out an `Application` for each from a single template — pointing at each service's Helm chart path and `values-dev.yaml`. `application-payments.yaml` is the equivalent hand-written version for payments alone, useful for understanding the pattern before the generated version.

Every `Application` here has `syncPolicy.automated` with `prune: true` and `selfHeal: true`. That's the actual trigger for deployment: when CI commits a new image tag into `values-dev.yaml`, ArgoCD detects the drift between Git and the live cluster state and reconciles it automatically — pulling the new image tag into a rolling update. So the full path from a code change to a running pod is:

```
push to app/** → CI builds + pushes image to ECR → CI commits new tag to values-dev.yaml
→ ArgoCD detects Git drift → ArgoCD syncs Helm release → EKS rolls out new pods
```

## Putting It Together

If you only remember one thing from this README: **Terraform issues identity, Kubernetes objects consume identity, CI/CD changes what Git says should be running, and ArgoCD makes the cluster match Git.** Every controller and workload in this repo — Karpenter, the Load Balancer Controller, both CSI drivers, ADOT, Grafana, and both microservices — follows that same identity pattern, which is what makes the platform predictable to extend: adding a fourth microservice means one more `workload-iam` module call, one more Helm chart, and one more entry in the `ApplicationSet` generator list, not a redesign.

## Disclaimer

This repository is a personal learning and demonstration project created to showcase Terraform, Amazon EKS, Kubernetes, Karpenter, Helm, GitHub Actions, Amazon ECR, ArgoCD, AWS Observability, and AWS platform integration patterns.