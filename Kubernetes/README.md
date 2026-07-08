# Kubernetes Manifests

## Overview

This folder contains Kubernetes and Helm-based configurations used for workloads and platform components running on Amazon EKS.

## Structure

```text
kubernetes/
├── aws-load-balancer-controller/
├── aws-secrets-provider/
├── ebs-csi-driver/
├── karpenter/
├── node-termination-handler/
├── orders-microservice/
├── payments-microservice/
└── secrets-store-csi-driver/


## Components

## Payments Microservice

Sample microservice used to demonstrate:

Helm-based deployment
HPA and PDB
Ingress
NetworkPolicy
ConfigMap
AWS Secrets Manager integration using Secrets Store CSI Driver

## Orders Microservice

Sample microservice used to demonstrate:

Helm-based deployment
StorageClass
PersistentVolumeClaim
EBS-backed volume mount

## Karpenter

Contains NodePool and EC2NodeClass manifests for dynamic node provisioning.

## AWS Load Balancer Controller
Contains environment-specific values for AWS Load Balancer Controller.

## Secrets Store CSI Driver
Contains environment-specific values for Secrets Store CSI Driver.

## AWS Secrets Provider
Contains environment-specific values for AWS Secrets and Configuration Provider.

## EBS CSI Driver
Documents EBS CSI Driver usage for persistent storage workloads.

## Node Termination Handler
Contains environment-specific values for handling Spot and node interruption events.

## Purpose
This folder demonstrates production-style Kubernetes workload deployment, autoscaling, traffic routing, storage, and secret management patterns on Amazon EKS.