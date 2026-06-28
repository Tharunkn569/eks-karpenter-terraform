variable "aws_region" {
  description = "AWS region where the EKS platform will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
  default     = "eks-karpenter-terraform"
}

variable "environment" {
  description = "Environment name such as dev, stage, or prod"
  type        = string
  default     = "dev"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-karpenter-dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets used by EKS worker nodes"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets used for NAT Gateway and load balancers"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "tags" {
  description = "Common tags applied to all supported resources"
  type        = map(string)

  default = {
    Project     = "eks-karpenter-terraform"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}