variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace for the workload"
  type        = string
}

variable "service_account_name" {
  description = "Kubernetes service account name for the workload"
  type        = string
}

variable "secret_arns" {
  description = "List of AWS Secrets Manager secret ARNs allowed for the workload"
  type        = list(string)
}

variable "tags" {
  description = "Common tags applied to workload IAM resources"
  type        = map(string)
  default     = {}
}