# EKS Karpenter Terraform

## Overview

This repository demonstrates a production-style Amazon EKS platform built using Terraform, Karpenter, Kubernetes, Helm, GitHub Actions, Amazon ECR, ArgoCD, and AWS Observability services.

The project includes infrastructure provisioning, dynamic node autoscaling, workload deployment, ingress traffic routing, secret management, persistent storage, CI/CD delivery, and observability patterns.

## Repository Structure

terraform/
- modules/
  - vpc/
  - eks/
  - karpenter/
  - platform-addons/
  - workload-iam/
  - github-oidc/
  - observability/

kubernetes/
- argocd/
- aws-load-balancer-controller/
- aws-secrets-provider/
- ebs-csi-driver/
- karpenter/
- node-termination-handler/
- observability/
- orders-microservice/
- payments-microservice/
- secrets-store-csi-driver/

app/
- payments-microservice/
- orders-microservice/

.github/workflows/
- ci-ecr-build.yml
- terraform-infra.yml

## Terraform Components

- VPC
- Amazon EKS
- Karpenter IAM and interruption queue
- Platform add-ons
- Workload IAM using EKS Pod Identity
- GitHub Actions OIDC role
- EBS CSI Driver integration
- AWS Load Balancer Controller IAM integration
- Secrets Manager workload access
- Amazon Managed Prometheus workspace
- Amazon Managed Grafana workspace
- ADOT Collector IAM using EKS Pod Identity

## Kubernetes Components

- Karpenter NodePool and EC2NodeClass
- AWS Load Balancer Controller
- Secrets Store CSI Driver
- AWS Secrets and Configuration Provider
- EBS CSI Driver
- Node Termination Handler
- ArgoCD
- ADOT Collector
- Prometheus Node Exporter
- Kube State Metrics
- Payments Microservice
- Orders Microservice

## Application Source

The app folder contains sample application source code used for Docker image builds.

Applications included:

- payments-microservice
- orders-microservice

Each application includes:

- Dockerfile
- nginx.conf
- index.html
- .dockerignore
- README.md

## Sample Microservices

### Payments Microservice

Used to demonstrate:

- Helm-based deployment
- HPA and PDB
- Ingress
- NetworkPolicy
- ConfigMap
- AWS Secrets Manager integration using Secrets Store CSI Driver
- SecretProviderClass
- EKS Pod Identity based workload access

### Orders Microservice

Used to demonstrate:

- Helm-based deployment
- StorageClass
- PersistentVolumeClaim
- EBS-backed persistent storage
- EBS CSI Driver based volume provisioning

## Observability

The observability layer demonstrates metrics collection and visualization using AWS-native monitoring services.

Components included:

- AWS Distro for OpenTelemetry
- ADOT Collector
- Amazon Managed Service for Prometheus
- Amazon Managed Grafana
- Prometheus Node Exporter
- Kube State Metrics

The ADOT Collector is configured to collect Kubernetes metrics and send them to Amazon Managed Prometheus using remote write.

Amazon Managed Grafana can be used to visualize metrics from Amazon Managed Prometheus.

## CI/CD Flow

This repository includes a CI/CD pattern using GitHub Actions, Amazon ECR, ArgoCD, Helm, and Amazon EKS.

Flow:

Developer Code Change

↓

GitHub Actions CI Workflow

↓

Docker Image Build

↓

Amazon ECR Image Push

↓

Helm Values Update

↓

ArgoCD GitOps Sync

↓

Amazon EKS Workload Deployment

## GitHub Actions

The GitHub Actions workflow builds Docker images for the sample microservices and pushes the images to Amazon ECR using OIDC-based AWS authentication.

Workflow:

- .github/workflows/ci-ecr-build.yml

## Infrastructure Pipeline

Infrastructure changes are handled through a separate Terraform pipeline.

Workflow:

- .github/workflows/terraform-infra.yml

The infrastructure pipeline is responsible for:

- Terraform format check
- Terraform validation
- Terraform plan
- Terraform apply with approval

## ArgoCD

ArgoCD is used for GitOps-based deployment of Helm charts to Amazon EKS.

ArgoCD application manifests are maintained under:

- kubernetes/argocd/

Applications managed:

- payments-microservice
- orders-microservice

## Key Capabilities

- Modular Terraform architecture
- Amazon EKS cluster provisioning
- Karpenter-based node provisioning
- Spot and On-Demand capacity support
- EKS Pod Identity integration
- EventBridge and SQS interruption handling
- ALB-based ingress pattern
- AWS Secrets Manager integration
- EBS-backed persistent storage
- AWS-native observability with ADOT, AMP, and AMG
- GitHub Actions CI with Amazon ECR
- ArgoCD GitOps-based CD
- Kubernetes workload governance

## Disclaimer

This repository is a personal learning and demonstration project created to showcase Terraform, Amazon EKS, Kubernetes, Karpenter, Helm, GitHub Actions, Amazon ECR, ArgoCD, AWS Observability, and AWS platform integration patterns.