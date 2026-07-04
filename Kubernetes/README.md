# Kubernetes Manifests

## Overview

This folder contains Kubernetes resources used to demonstrate application deployment, autoscaling, resilience, and dynamic node provisioning on Amazon EKS.

## Structure

```text
kubernetes/
├── karpenter/
├── node-termination-handler/
└── payments-microservice/
```

## Components

### Karpenter

Contains manifests related to dynamic node provisioning.

Key capabilities:

- Dynamic node provisioning
- Spot and On-Demand capacity support
- Node consolidation
- Interruption handling integration

### Node Termination Handler

Contains environment-specific configuration used to improve workload resilience during node interruption events.

### Payments Microservice

Sample workload used to demonstrate:

- Helm-based deployment
- Application scaling using HPA
- Workload protection using PDB
- Karpenter-driven node provisioning

## Purpose

These manifests demonstrate production-style Kubernetes deployment patterns and operational practices commonly used on Amazon EKS.