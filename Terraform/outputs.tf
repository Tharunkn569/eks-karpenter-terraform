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

output "ebs_csi_driver_role_arn" {
  description = "IAM role ARN used by EBS CSI Driver"
  value       = module.platform_addons.ebs_csi_driver_role_arn
}

output "ebs_csi_driver_addon_name" {
  description = "EKS add-on name for EBS CSI Driver"
  value       = module.platform_addons.ebs_csi_driver_addon_name
}

output "aws_secrets_provider_addon_name" {
  description = "EKS add-on name for AWS Secrets Store CSI Provider"
  value       = module.platform_addons.aws_secrets_provider_addon_name
}

output "payments_workload_role_arn" {
  description = "IAM role ARN used by payments microservice through EKS Pod Identity"
  value       = module.payments_workload_iam.role_arn
}

output "aws_load_balancer_controller_role_arn" {
  description = "IAM role ARN used by AWS Load Balancer Controller"
  value       = module.platform_addons.aws_load_balancer_controller_role_arn
}

output "payments_ecr_repository_url" {
  description = "ECR repository URL for payments microservice"
  value       = module.platform_addons.payments_ecr_repository_url
}

output "orders_ecr_repository_url" {
  description = "ECR repository URL for orders microservice"
  value       = module.platform_addons.orders_ecr_repository_url
}

output "github_actions_role_arn" {
  description = "IAM role ARN used by GitHub Actions through OIDC"
  value       = module.github_oidc.github_actions_role_arn
}

output "ebs_csi_driver_role_arn" {
  description = "IAM role ARN used by EBS CSI Driver"
  value       = module.platform_addons.ebs_csi_driver_role_arn
}

output "amp_workspace_id" {
  description = "Amazon Managed Prometheus workspace ID"
  value       = module.observability.amp_workspace_id
}

output "amp_workspace_arn" {
  description = "Amazon Managed Prometheus workspace ARN"
  value       = module.observability.amp_workspace_arn
}

output "amp_remote_write_endpoint" {
  description = "Amazon Managed Prometheus remote write endpoint"
  value       = module.observability.amp_remote_write_endpoint
}

output "adot_collector_role_arn" {
  description = "IAM role ARN used by ADOT collector"
  value       = module.observability.adot_collector_role_arn
}