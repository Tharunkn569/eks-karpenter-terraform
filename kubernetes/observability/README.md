# Observability

## Overview

This folder contains observability-related Kubernetes configuration for Amazon EKS.

The observability stack is based on AWS Distro for OpenTelemetry, Amazon Managed Service for Prometheus, and Amazon Managed Grafana.

## Components

- ADOT Collector
- Prometheus Node Exporter
- Kube State Metrics
- Amazon Managed Prometheus
- Amazon Managed Grafana

## Purpose

This configuration demonstrates cluster-level monitoring and metrics collection for workloads running on Amazon EKS.

The ADOT Collector collects metrics from Kubernetes workloads and exports them to Amazon Managed Prometheus.

Amazon Managed Grafana can be used to visualize metrics from Amazon Managed Prometheus.