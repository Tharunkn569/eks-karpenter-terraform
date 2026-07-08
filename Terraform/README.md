# Terraform Infrastructure

## Overview

This folder contains the Infrastructure as Code (IaC) components used to provision the Amazon EKS platform.

The infrastructure is organized into reusable modules to simplify management, scalability, and future enhancements.

## Structure

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
    ├── karpenter/
    ├── platform-addons/
    └── workload-iam/

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

### Platform Add-ons

Provisions IAM and add-on integrations for platform components, including:

- EBS CSI Driver
- AWS Secrets Store CSI Provider
- AWS Load Balancer Controller Pod Identity

### Workload IAM

Provisions IAM roles and EKS Pod Identity associations for Kubernetes workloads.

Currently used for:

- Payments Microservice access to AWS Secrets Manager

## Features

- Modular Terraform design
- Environment-driven configuration
- Reusable infrastructure components
- Karpenter integration
- EKS Pod Identity support
- Spot interruption handling
- Platform add-on integration
- Workload IAM using EKS Pod Identity
- AWS Secrets Manager access for workloads
- EBS CSI Driver integration
- AWS Load Balancer Controller IAM integration


## Purpose

This infrastructure demonstrates a production-style Amazon EKS platform using Terraform and Karpenter while following modular Infrastructure as Code practices.