resource "aws_prometheus_workspace" "this" {
  alias = var.amp_workspace_alias

  tags = var.tags
}