# Payments Microservice

## Overview

The Payments Microservice is a sample application deployed on Amazon EKS to demonstrate Kubernetes workload deployment, autoscaling, and resilience patterns.

This application is used to validate Karpenter node provisioning, Horizontal Pod Autoscaling (HPA), and Pod Disruption Budget (PDB) configurations.

## Features

- Helm-based deployment
- Kubernetes Deployment and Service
- Horizontal Pod Autoscaler (HPA)
- Pod Disruption Budget (PDB)
- Karpenter-compatible workload scheduling
- Separate configuration for dev and prod environments
- Network Policy
- Service Account
- ConfigMap-based application configuration
- Dedicated PriorityClass for workload prioritization
- Namespace ResourceQuota controls
- LimitRange for default container resource governance
- AWS Secrets Manager integration using Secrets Store CSI Driver
- SecretProviderClass-based secret mounting


## Helm Structure

payments-microservice/
├── Chart.yaml
├── values-dev.yaml
├── values-prod.yaml
└── templates/
    ├── namespace.yaml
    ├── deployment.yaml
    ├── service.yaml
    ├── hpa.yaml
    └── pdb.yaml

## Environment Configuration

### Development

helm install payments ./payments-microservice \
-f values-dev.yaml \
-n payments

### Production


helm install payments ./payments-microservice \
-f values-prod.yaml \
-n payments


## Autoscaling

The application uses Kubernetes Horizontal Pod Autoscaler (HPA) to automatically scale pods based on CPU utilization.

Example configuration:

- Minimum replicas: Configurable per environment
- Maximum replicas: Configurable per environment
- Target CPU Utilization: 60%

## Pod Disruption Budget

The application includes a Pod Disruption Budget (PDB) to maintain application availability during:

- Karpenter consolidation
- Node upgrades
- Spot interruption handling
- Voluntary node drains

Current configuration:

```yaml
maxUnavailable: 2
```
## Secrets Manager Integration

The Payments Microservice uses a dedicated Kubernetes ServiceAccount.

payments-microservice

## Health Checks

The deployment includes:

- Readiness Probe
- Liveness Probe

These probes ensure traffic is routed only to healthy application instances.

## Testing

Verify deployment:

```bash
kubectl get pods -n payments
```

Verify service:

```bash
kubectl get svc -n payments
```

Verify HPA:

```bash
kubectl get hpa -n payments
```

Verify PDB:

```bash
kubectl get pdb -n payments
```

## Purpose

This microservice is intentionally simple and serves as a demonstration workload for validating:

- Amazon EKS deployment patterns
- Helm-based application delivery
- Karpenter node provisioning
- Kubernetes autoscaling
- Workload resilience and availability