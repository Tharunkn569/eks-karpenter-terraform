# Application Source

## Overview

This folder contains sample application source code used for Docker image builds in the GitHub Actions CI workflow.

## Applications

- payments-microservice
- orders-microservice

## Purpose

These applications are used to demonstrate container image build and push to Amazon ECR using GitHub Actions.

The Kubernetes Helm charts for these applications are maintained under:

- kubernetes/payments-microservice
- kubernetes/orders-microservice

## CI Integration

The GitHub Actions workflow builds Docker images for both microservices and pushes them to Amazon ECR.

Workflow file:

- .github/workflows/ci-ecr-build.yml