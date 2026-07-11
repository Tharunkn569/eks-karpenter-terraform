resource "aws_eks_addon" "adot" {
  cluster_name                = var.cluster_name
  addon_name                  = "adot"
  resolve_conflicts_on_update = "OVERWRITE"

  tags = var.tags
}

resource "aws_eks_addon" "prometheus_node_exporter" {
  cluster_name                = var.cluster_name
  addon_name                  = "prometheus-node-exporter"
  resolve_conflicts_on_update = "OVERWRITE"

  tags = var.tags
}

resource "aws_eks_addon" "kube_state_metrics" {
  cluster_name                = var.cluster_name
  addon_name                  = "kube-state-metrics"
  resolve_conflicts_on_update = "OVERWRITE"

  tags = var.tags
}