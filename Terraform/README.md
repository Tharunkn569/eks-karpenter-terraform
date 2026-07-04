# Terraform Infrastructure

## Overview

This folder contains the Infrastructure as Code (IaC) components used to provision the Amazon EKS platform.

The infrastructure is organized into reusable modules to simplify management, scalability, and future enhancements.

## Structure

```text
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── terraform.tfvars.example
│
└── modules/
    ├── vpc/
    ├── eks/
    └── karpenter/
```

## Modules

### VPC

Provisions the networking layer for the platform, including:

- VPC
- Public subnets
- Private subnets
- Internet Gateway

### EKS

Provisions the Amazon EKS cluster and supporting resources, including:

- EKS Cluster
- IAM Roles
- EKS Add-ons
- Cluster Networking

### Karpenter

Provisions resources required for Karpenter integration, including:

- IAM Roles
- Pod Identity Association
- EventBridge Rules
- SQS Interruption Queue

## Features

- Modular Terraform design
- Environment-driven configuration
- Reusable infrastructure components
- Karpenter integration
- EKS Pod Identity support
- Spot interruption handling

## Purpose

This infrastructure demonstrates a production-style Amazon EKS platform using Terraform and Karpenter while following modular Infrastructure as Code practices.