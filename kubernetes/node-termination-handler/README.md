# Node Termination Handler

## Overview

Node Termination Handler (NTH) is used to improve workload resilience on Amazon EKS by responding to infrastructure events that may impact running nodes.

In this project, NTH complements Karpenter by helping workloads handle node interruptions gracefully.

## Purpose

The configuration demonstrates how production EKS environments can respond to:

- EC2 Spot interruption notifications
- Scheduled maintenance events
- Instance rebalance recommendations
- Node termination events

## Environment Configuration

Separate configuration files are maintained for different environments:

```text
values-dev.yaml
values-prod.yaml
```

## Key Features

- Spot interruption awareness
- Scheduled event handling
- Rebalance monitoring
- Graceful node draining
- Environment-specific configuration

## Design Considerations

This implementation follows a production-style approach where:

- Karpenter handles dynamic node provisioning
- Node Termination Handler improves interruption awareness
- Workloads remain protected through Kubernetes disruption controls
- Spot instances can be utilized while maintaining application availability

## Relationship with Karpenter

This project uses both Karpenter and Node Termination Handler to demonstrate resilient node lifecycle management.

Responsibilities include:

| Component | Responsibility |
|------------|---------------|
| Karpenter | Dynamic node provisioning and consolidation |
| Node Termination Handler | Infrastructure interruption awareness |
| Pod Disruption Budget | Application availability during disruptions |
| Horizontal Pod Autoscaler | Pod-level scaling |

## Expected Outcome

Together, these components help demonstrate:

- Cost optimization using Spot capacity
- Automated node lifecycle management
- Improved workload resilience
- Production-style EKS operational patterns