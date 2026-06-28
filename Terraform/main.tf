provider "aws" {
  region = var.aws_region
}

# -----------------------------
# VPC MODULE
# -----------------------------
module "vpc" {
  source = "./modules/vpc"

  vpc_name = var.project_name
  cidr_block = var.vpc_cidr
}

# -----------------------------
# EKS MODULE
# -----------------------------
module "eks" {
  source = "./modules/eks"

  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnets
}

# -----------------------------
# KARPENTER MODULE
# -----------------------------
module "karpenter" {
  source = "./modules/karpenter"

  cluster_name = module.eks.cluster_name
}