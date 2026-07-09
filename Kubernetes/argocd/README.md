# ArgoCD

## Overview

This folder contains ArgoCD-related configuration for GitOps-based application delivery on Amazon EKS.

ArgoCD is used to manage Kubernetes workloads from Git and keep the cluster state in sync with the repository.

## Files

- values-dev.yaml
- values-prod.yaml
- application-payments.yaml
- application-orders.yaml
- applicationset.yaml

## Purpose

ArgoCD is used in this project to demonstrate continuous delivery for Helm-based microservices running on Amazon EKS.

The following microservices are managed through ArgoCD:

- Payments Microservice
- Orders Microservice

## CI/CD Flow

Developer Code Change
↓
GitHub Actions CI
↓
Docker Image Build
↓
Amazon ECR Push
↓
ArgoCD GitOps Sync
↓
Amazon EKS Deployment

## Sections Covered

### 01_CI_github_actions_AWS_ECR

GitHub Actions workflow builds the Docker image and pushes it to Amazon ECR using secure OIDC-based authentication.

### 02_CD_ArgoCD_Install

ArgoCD configuration is maintained for installation and environment-specific setup on Amazon EKS.

### 03_CD_ArgoCD_Helm

ArgoCD applications are configured to deploy Helm charts from this Git repository.

### 04_CI_CD_Full_Flow_Test

The end-to-end flow demonstrates image build, image push, GitOps sync, and workload deployment to Amazon EKS.

## Applications

ArgoCD applications included in this project:

- application-payments.yaml
- application-orders.yaml
- applicationset.yaml

## Repository

https://github.com/Tharunkn569/eks-karpenter-terraform.git

## Purpose in Project

This ArgoCD configuration demonstrates:

- GitOps-based deployment
- Helm chart integration
- Automated sync policy
- Self-healing application state
- Multi-microservice deployment pattern