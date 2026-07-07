# AWS Secrets and Configuration Provider

## Overview

This folder contains environment-specific configuration for AWS Secrets and Configuration Provider (ASCP).

## Files

values-dev.yaml
values-prod.yaml


## Purpose

AWS Secrets and Configuration Provider integrates AWS Secrets Manager with Secrets Store CSI Driver.

In this project, ASCP is used to retrieve secrets from AWS Secrets Manager and make them available to Kubernetes workloads through SecretProviderClass resources.