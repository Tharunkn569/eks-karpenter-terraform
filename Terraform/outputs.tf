output "vpc_id" {
  description = "ID of the VPC created for the EKS platform"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs used by EKS worker nodes"
  value       = module.vpc.private_subnets
}

output "public_subnet_ids" {
  description = "Public subnet IDs used for external access and load balancers"
  value       = module.vpc.public_subnets
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Endpoint URL of the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_security_group_id" {
  description = "Security group ID associated with the EKS cluster"
  value       = module.eks.cluster_security_group_id
}


output "karpenter_controller_role_arn" {
  description = "IAM role ARN used by Karpenter controller"
  value       = module.karpenter.karpenter_controller_role_arn
}

output "karpenter_node_role_name" {
  description = "IAM role name used by Karpenter-created EC2 nodes"
  value       = module.karpenter.karpenter_node_role_name
}

output "karpenter_interruption_queue_name" {
  description = "SQS queue name used by Karpenter for Spot interruption handling"
  value       = module.karpenter.interruption_queue_name
}