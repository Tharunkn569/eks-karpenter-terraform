# GitHub Actions Workflows

## Overview

This folder contains GitHub Actions workflows used for CI/CD automation.

## Files

- ci-ecr-build.yml
- terraform-infra.yaml

## 01_CI_github_actions_AWS_ECR

The CI workflow builds the Docker image for the Payments Microservice and pushes the image to Amazon ECR.

This workflow uses GitHub OIDC authentication to assume an AWS IAM role securely without storing long-term AWS access keys in GitHub.

## 02_CD_ArgoCD_Install

ArgoCD installation and configuration are maintained separately under the kubernetes/argocd folder.

## 03_CD_ArgoCD_Helm

ArgoCD applications deploy Helm charts from this repository.

The Payments Microservice and Orders Microservice are configured as ArgoCD applications.

## 04_CI_CD_Full_Flow_Test

The intended end-to-end flow is:

App code change in app/
↓
GitHub Actions builds Docker image
↓
Image pushed to ECR
↓
Workflow updates Helm values-dev.yaml image tag
↓
Git commit pushed
↓
ArgoCD detects Git change
↓
ArgoCD auto sync deploys to EKS

## Required GitHub Secrets

- AWS_GITHUB_ACTIONS_ROLE_ARN
- ARGOCD_USERNAME
- ARGOCD_PASSWORD

## Purpose

These workflows demonstrate a production-style CI/CD pattern using GitHub Actions, Amazon ECR, ArgoCD, Helm, and Amazon EKS.