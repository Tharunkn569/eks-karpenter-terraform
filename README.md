# EKS Karpenter Terraform

## Overview

This repository demonstrates a production-style Amazon EKS platform built using Terraform, Karpenter, Kubernetes, Helm, GitHub Actions, Amazon ECR, and ArgoCD.

The project includes infrastructure provisioning, dynamic node autoscaling, workload deployment, ingress traffic routing, secret management, persistent storage, and CI/CD delivery patterns.

## Repository Structure

terraform/
- modules/
  - vpc/
  - eks/
  - karpenter/
  - platform-addons/
  - workload-iam/

kubernetes/
- aws-load-balancer-controller/
- aws-secrets-provider/
- ebs-csi-driver/
- karpenter/
- node-termination-handler/
- orders-microservice/
- payments-microservice/
- secrets-store-csi-driver/
- argocd/

app/
- payments-microservice/
- orders-microservice/

.github/workflows/
- ci-ecr-build.yml
- cd-argocd-sync.yml

## Terraform Components

- VPC
- Amazon EKS
- Karpenter IAM and interruption queue
- Platform add-ons
- Workload IAM using EKS Pod Identity
- EBS CSI Driver integration
- AWS Load Balancer Controller IAM integration
- Secrets Manager workload access

## Kubernetes Components

- Karpenter NodePool and EC2NodeClass
- AWS Load Balancer Controller
- Secrets Store CSI Driver
- AWS Secrets and Configuration Provider
- EBS CSI Driver
- Node Termination Handler
- ArgoCD
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

ArgoCD GitOps Sync

↓  

Helm Deployment

↓  

Amazon EKS Workload Deployment

## GitHub Actions

The GitHub Actions workflow builds Docker images for the sample microservices and pushes the images to Amazon ECR using OIDC-based AWS authentication.

Workflow:

- .github/workflows/ci-ecr-build.yml

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
- GitHub Actions CI with Amazon ECR
- ArgoCD GitOps-based CD
- Kubernetes workload governance

## Disclaimer

This repository is a personal learning and demonstration project created to showcase Terraform, Amazon EKS, Kubernetes, Karpenter, Helm, GitHub Actions, Amazon ECR, ArgoCD, and AWS platform integration patterns.
