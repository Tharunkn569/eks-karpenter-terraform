variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "karpenter_namespace" {
  description = "Namespace where Karpenter will be installed"
  type        = string
  default     = "karpenter"
}

variable "karpenter_service_account" {
  description = "Karpenter controller service account name"
  type        = string
  default     = "karpenter"
}

variable "tags" {
  description = "Common tags applied to Karpenter resources"
  type        = map(string)
  default     = {}
}