# EBS CSI Driver

## Overview

This folder documents the Amazon EBS CSI Driver integration for Amazon EKS.

## Purpose

Amazon EBS CSI Driver enables Kubernetes workloads to use Amazon EBS volumes through PersistentVolumes and PersistentVolumeClaims.

In this project, EBS CSI Driver will be used by the Orders Microservice to demonstrate persistent storage on Amazon EKS.

## Usage in Project

The Orders Microservice will use:

- StorageClass
- PersistentVolumeClaim
- EBS-backed volume mount
- EKS add-on based EBS CSI Driver integration