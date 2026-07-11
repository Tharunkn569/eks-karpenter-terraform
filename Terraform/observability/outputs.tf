output "amp_workspace_id" {
  description = "Amazon Managed Prometheus workspace ID"
  value       = aws_prometheus_workspace.this.id
}

output "amp_workspace_arn" {
  description = "Amazon Managed Prometheus workspace ARN"
  value       = aws_prometheus_workspace.this.arn
}

output "amp_remote_write_endpoint" {
  description = "Amazon Managed Prometheus remote write endpoint"
  value       = aws_prometheus_workspace.this.prometheus_endpoint
}

output "adot_collector_role_arn" {
  description = "IAM role ARN used by ADOT collector"
  value       = aws_iam_role.adot_collector.arn
}