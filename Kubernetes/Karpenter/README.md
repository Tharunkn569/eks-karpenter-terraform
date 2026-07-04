# Karpenter Configuration

## Overview

This folder contains Karpenter configuration used for dynamic node provisioning in Amazon EKS.

## Files

- ec2nodeclass.yaml
- nodepool.yaml
- provisioner-legacy.yaml

## Features

- Dynamic node provisioning
- Spot and On-Demand capacity support
- Node consolidation
- Interruption handling integration
- EKS Pod Identity integration

## Components

### EC2NodeClass

Defines AWS-specific configuration used when launching EC2 instances.

### NodePool

Defines node provisioning requirements, capacity types, and disruption settings.

### Legacy Provisioner

Included as a reference for older Karpenter versions. Current implementations use NodePool and EC2NodeClass.

## Purpose

This configuration demonstrates production-style EKS autoscaling and node lifecycle management using Karpenter.