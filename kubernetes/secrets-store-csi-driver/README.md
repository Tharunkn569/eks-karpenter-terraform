# Secrets Store CSI Driver

## Overview

This folder contains environment-specific configuration for Secrets Store CSI Driver.

## Files

values-dev.yaml
values-prod.yaml

## Purpose

Secrets Store CSI Driver enables Kubernetes workloads to mount secrets from external secret stores as volumes.
In this project, it is used with AWS Secrets Manager and AWS Secrets and Configuration Provider to securely provide secrets to the Payments Microservice.

Usage in Project
The Payments Microservice will use:

AWS Secrets Manager
Secrets Store CSI Driver
AWS Secrets and Configuration Provider
SecretProviderClass
Kubernetes ServiceAccount with IAM access