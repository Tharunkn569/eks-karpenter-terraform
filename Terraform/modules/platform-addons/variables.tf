variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "tags" {
  description = "Common tags applied to platform add-on resources"
  type        = map(string)
  default     = {}
}