# ArgoCD

## Overview

This folder contains ArgoCD configuration for GitOps-based application delivery on Amazon EKS.

ArgoCD is used to manage Kubernetes workloads from Git and keep the cluster state synchronized with this repository.

## Files

- values-dev.yaml
- values-prod.yaml
- application-project.yaml
- application-payments.yaml
- application-orders.yaml
- applicationset.yaml

## Purpose

ArgoCD is used in this project to demonstrate continuous delivery for Helm-based microservices running on Amazon EKS.

The following microservices are managed through ArgoCD:

- Payments Microservice
- Orders Microservice

## ArgoCD Project

The application-project.yaml file defines an ArgoCD AppProject named microservices.

This project controls:

- Allowed Git source repository
- Allowed deployment namespaces
- Cluster and namespace resource permissions

## Applications

The following ArgoCD applications are included:

- application-payments.yaml
- application-orders.yaml
- applicationset.yaml

## Helm Integration

ArgoCD deploys the Payments Microservice and Orders Microservice using Helm charts stored in this repository.

Each microservice maintains separate values files for environment-specific configuration.

## CI/CD Flow

Developer Code Change

↓

GitHub Actions CI

↓

Docker Image Build

↓

Amazon ECR Push

↓

Helm Values Update

↓

ArgoCD GitOps Sync

↓

Amazon EKS Deployment

## Sections Covered

### 01_CI_github_actions_AWS_ECR

GitHub Actions builds Docker images for microservices and pushes them to Amazon ECR using secure OIDC authentication.

### 02_CD_ArgoCD_Install

ArgoCD configuration is maintained for installation and environment-specific setup on Amazon EKS.

### 03_CD_ArgoCD_Helm

ArgoCD applications deploy Helm charts from this Git repository.

### 04_CI_CD_Full_Flow_Test

The full flow demonstrates image build, image push, Helm values update, ArgoCD sync, and workload deployment to Amazon EKS.

## Repository

https://github.com/Tharunkn569/eks-karpenter-terraform.git