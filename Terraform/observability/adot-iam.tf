resource "aws_iam_role" "adot_collector" {
  name = "${var.cluster_name}-adot-collector-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_policy" "adot_collector" {
  name        = "${var.cluster_name}-adot-collector-policy"
  description = "IAM policy for ADOT collector to remote write metrics to Amazon Managed Prometheus"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "aps:RemoteWrite",
          "aps:GetSeries",
          "aps:GetLabels",
          "aps:GetMetricMetadata"
        ]
        Resource = aws_prometheus_workspace.this.arn
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "adot_collector" {
  role       = aws_iam_role.adot_collector.name
  policy_arn = aws_iam_policy.adot_collector.arn
}

resource "aws_eks_pod_identity_association" "adot_collector" {
  cluster_name    = var.cluster_name
  namespace       = var.adot_namespace
  service_account = var.adot_service_account
  role_arn        = aws_iam_role.adot_collector.arn
}