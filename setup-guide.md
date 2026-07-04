# Setup Guide

## Overview

This project demonstrates a production-style Amazon EKS platform built using Terraform and Karpenter.

The repository includes infrastructure provisioning, node autoscaling components, and a sample Payments Microservice deployment.

## Infrastructure Components

### Networking

- VPC
- Public Subnets
- Private Subnets
- Internet Gateway

### Amazon EKS

- EKS Cluster
- EKS Pod Identity Agent
- Cluster IAM Roles

### Karpenter

- Dynamic node provisioning
- Spot and On-Demand capacity support
- Interruption handling integration
- Node lifecycle management

## Kubernetes Components

### Payments Microservice

- Helm Chart
- Deployment
- Service
- Horizontal Pod Autoscaler
- Pod Disruption Budget

### Node Termination Handler

- Spot interruption awareness
- Scheduled maintenance awareness
- Graceful workload protection

## Repository Layout

```text
terraform/
kubernetes/
docs/
.github/
```

## Environment Configuration

The project maintains separate configuration for different environments where applicable.

Examples:

```text
values-dev.yaml
values-prod.yaml
terraform.tfvars.example
```

## Design Goals

- Modular Infrastructure as Code
- Kubernetes workload resilience
- Cost optimization through Spot capacity
- Automated node provisioning
- Production-style repository structure

## Future Enhancements

- AWS Load Balancer Controller
- Ingress resources
- External Secrets Operator
- AWS Secrets Manager integration
- Prometheus and Grafana monitoring
- ArgoCD GitOps deployment