# Terraform Infrastructure

## Overview

This folder contains the Terraform Infrastructure as Code configuration for provisioning the Amazon EKS platform and supporting AWS services.

The Terraform code is organized using reusable modules for networking, EKS, Karpenter, platform add-ons, workload IAM, GitHub OIDC, and observability.

## Structure

Terraform/
- main.tf
- variables.tf
- outputs.tf
- versions.tf
- terraform.tfvars.example

Terraform/modules/
- vpc/
- eks/
- karpenter/
- platform-addons/
- workload-iam/
- github-oidc/
- observability/

## Modules

### VPC

Provisions the networking layer for the EKS platform.

Includes:

- VPC
- Public subnets
- Private subnets
- Internet Gateway

### EKS

Provisions the Amazon EKS cluster and supporting cluster resources.

Includes:

- EKS Cluster
- Cluster IAM roles
- EKS Pod Identity Agent
- EKS add-ons

### Karpenter

Provisions AWS resources required for Karpenter integration.

Includes:

- Karpenter controller IAM role
- Karpenter node IAM role
- EKS Pod Identity association
- SQS interruption queue
- EventBridge interruption rules

### Platform Add-ons

Provisions AWS and IAM resources for platform-level EKS add-ons.

Includes:

- AWS Load Balancer Controller IAM integration
- EBS CSI Driver integration
- AWS Secrets Store CSI Provider
- ECR repositories for microservices

### Workload IAM

Provisions IAM roles and EKS Pod Identity associations for Kubernetes workloads.

Currently used for:

- Payments Microservice access to AWS Secrets Manager

### GitHub OIDC

Provisions IAM resources used by GitHub Actions to authenticate with AWS using OIDC.

Used for:

- Secure ECR image push from GitHub Actions
- Avoiding long-term AWS access keys in GitHub

### Observability

Provisions AWS observability resources for the EKS platform.

Includes:

- ADOT Collector IAM role
- ADOT Collector EKS Pod Identity association
- ADOT EKS add-on
- Prometheus Node Exporter EKS add-on
- Kube State Metrics EKS add-on
- Amazon Managed Prometheus workspace
- Amazon Managed Grafana workspace

## Key Capabilities

- Modular Terraform architecture
- Amazon EKS cluster provisioning
- EKS Pod Identity integration
- Karpenter autoscaling support
- Spot interruption handling
- Platform add-on integration
- Workload IAM integration
- GitHub Actions OIDC integration
- Amazon ECR repositories
- AWS Secrets Manager access for workloads
- EBS CSI Driver support
- AWS-native observability with ADOT, AMP, and AMG

## Purpose

This Terraform configuration demonstrates a production-style Amazon EKS platform using modular Infrastructure as Code practices.