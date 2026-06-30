output "karpenter_controller_role_arn" {
  description = "IAM role ARN used by Karpenter controller through EKS Pod Identity"
  value       = aws_iam_role.karpenter_controller.arn
}

output "karpenter_node_role_name" {
  description = "IAM role name used by Karpenter-created EC2 nodes"
  value       = aws_iam_role.karpenter_node.name
}

output "karpenter_node_role_arn" {
  description = "IAM role ARN used by Karpenter-created EC2 nodes"
  value       = aws_iam_role.karpenter_node.arn
}

output "interruption_queue_name" {
  description = "SQS queue name used by Karpenter for interruption handling"
  value       = aws_sqs_queue.karpenter_interruption.name
}

output "interruption_queue_arn" {
  description = "SQS queue ARN used by Karpenter for interruption handling"
  value       = aws_sqs_queue.karpenter_interruption.arn
}