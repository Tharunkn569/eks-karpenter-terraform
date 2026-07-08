output "ebs_csi_driver_role_arn" {
  description = "IAM role ARN used by EBS CSI Driver"
  value       = aws_iam_role.ebs_csi_driver.arn
}

output "ebs_csi_driver_addon_name" {
  description = "EKS add-on name for EBS CSI Driver"
  value       = aws_eks_addon.ebs_csi_driver.addon_name
}

output "aws_secrets_provider_addon_name" {
  description = "EKS add-on name for AWS Secrets Store CSI Provider"
  value       = aws_eks_addon.aws_secrets_provider.addon_name
}

output "aws_load_balancer_controller_role_arn" {
  description = "IAM role ARN used by AWS Load Balancer Controller"
  value       = aws_iam_role.aws_load_balancer_controller.arn
}