# EKS Karpenter Terraform

## Overview

This repository demonstrates a production-style Amazon EKS platform built using Terraform, Karpenter, and Kubernetes.

The project includes infrastructure provisioning, dynamic node autoscaling, workload deployment, ingress traffic routing, secret management, and persistent storage patterns.

## Repository Structure

```text
terraform/
├── modules/
│   ├── vpc/
│   ├── eks/
│   ├── karpenter/
│   ├── platform-addons/
│   └── workload-iam/

kubernetes/
├── aws-load-balancer-controller/
├── aws-secrets-provider/
├── ebs-csi-driver/
├── karpenter/
├── node-termination-handler/
├── orders-microservice/
├── payments-microservice/
└── secrets-store-csi-driver/
```

## Terraform Components

- VPC
- Amazon EKS
- Karpenter IAM and interruption queue
- Platform add-ons
- Workload IAM using EKS Pod Identity

## Kubernetes Components

- Karpenter NodePool and EC2NodeClass
- AWS Load Balancer Controller
- Secrets Store CSI Driver
- AWS Secrets and Configuration Provider
- EBS CSI Driver
- Node Termination Handler
- Payments Microservice
- Orders Microservice

## Sample Microservices

### Payments Microservice

Used to demonstrate:

- Helm-based deployment
- HPA and PDB
- Ingress
- NetworkPolicy
- ConfigMap
- AWS Secrets Manager integration

### Orders Microservice

Used to demonstrate:

- Helm-based deployment
- StorageClass
- PersistentVolumeClaim
- EBS-backed persistent storage

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
- Kubernetes workload governance

## CI/CD Flow

Developer Code Change
↓
GitHub Actions
↓
Docker Image Build
↓
Amazon ECR
↓
ArgoCD Sync
↓
Amazon EKS Deployment

## Disclaimer

This repository is a personal learning and demonstration project created to showcase Terraform, Amazon EKS, Kubernetes, Karpenter, and AWS platform integration patterns.