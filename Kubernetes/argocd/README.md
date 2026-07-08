# ArgoCD

## Overview

This folder contains configuration related to ArgoCD integration.

## Files

```text
values-dev.yaml
values-prod.yaml
```

## Purpose

ArgoCD is used to implement GitOps-based application delivery for workloads running on Amazon EKS.

The Payments Microservice and Orders Microservice can be deployed and managed through ArgoCD applications using Helm charts stored in Git repositories.