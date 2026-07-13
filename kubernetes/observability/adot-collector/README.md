# ADOT Collector

## Overview

This folder contains ADOT Collector configuration for Amazon EKS observability.

## Files

- collector-dev.yaml
- collector-prod.yaml

## Purpose

ADOT Collector is used to collect Kubernetes metrics and export them to Amazon Managed Prometheus.

The collector uses a dedicated Kubernetes ServiceAccount associated with an IAM role through EKS Pod Identity.