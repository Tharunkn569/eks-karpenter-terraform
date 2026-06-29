variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the EKS cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for EKS cluster networking"
  type        = list(string)
}

variable "tags" {
  description = "Common tags applied to EKS resources"
  type        = map(string)
  default     = {}
}