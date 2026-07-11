# Kube State Metrics

## Overview

This folder contains environment-specific configuration for Kube State Metrics.

## Files

- values-dev.yaml
- values-prod.yaml

## Purpose

Kube State Metrics exposes Kubernetes object state metrics such as deployments, pods, replicasets, nodes, and namespaces.

These metrics are collected by ADOT Collector and exported to Amazon Managed Prometheus.