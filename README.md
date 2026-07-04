# EKS Karpenter Terraform

## Overview

This repository demonstrates a production-style Amazon EKS platform built using Terraform and Karpenter.

The project provisions AWS infrastructure including VPC, EKS, Karpenter integration, interruption handling, and Kubernetes workloads. A sample Payments Microservice is included to demonstrate autoscaling and workload resilience patterns.

## Components

### Terraform

- VPC
- EKS
- Karpenter
- EventBridge
- SQS
- IAM Roles
- EKS Pod Identity

### Kubernetes

- Karpenter NodePool
- EC2NodeClass
- Node Termination Handler
- Payments Microservice
- Horizontal Pod Autoscaler (HPA)
- Pod Disruption Budget (PDB)

## Repository Structure

```text
terraform/
├── modules/
│   ├── vpc/
│   ├── eks/
│   └── karpenter/

kubernetes/
├── karpenter/
├── node-termination-handler/
└── payments-microservice/
```

## Key Features

- Modular Terraform architecture
- Amazon EKS deployment
- Karpenter-based node provisioning
- Spot and On-Demand capacity support
- EKS Pod Identity integration
- Interruption handling using EventBridge and SQS
- Helm-based application deployment
- Kubernetes autoscaling and disruption controls

## Sample Workload

The Payments Microservice is included to demonstrate:

- Helm-based deployment patterns
- Application scaling using HPA
- Workload availability using PDB
- Karpenter-driven node provisioning

## Disclaimer

This repository is a personal learning and demonstration project created to showcase Terraform, Amazon EKS, Kubernetes, and Karpenter implementation patterns.