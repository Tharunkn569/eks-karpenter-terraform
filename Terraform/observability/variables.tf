variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "adot_namespace" {
  description = "Namespace where ADOT collector will run"
  type        = string
  default     = "observability"
}

variable "adot_service_account" {
  description = "Service account name used by ADOT collector"
  type        = string
  default     = "adot-collector"
}

variable "amp_workspace_alias" {
  description = "Alias name for Amazon Managed Prometheus workspace"
  type        = string
  default     = "eks-karpenter-amp"
}

variable "tags" {
  description = "Common tags applied to observability resources"
  type        = map(string)
  default     = {}
}