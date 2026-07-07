output "role_name" {
  description = "IAM role name associated with the workload service account"
  value       = aws_iam_role.this.name
}

output "role_arn" {
  description = "IAM role ARN associated with the workload service account"
  value       = aws_iam_role.this.arn
}