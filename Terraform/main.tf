provider "aws" {
  region = var.aws_region
}

# -----------------------------
# VPC MODULE
# -----------------------------
module "vpc" {
  source = "./modules/vpc"

  vpc_name             = var.project_name
  cidr_block           = var.vpc_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
  tags                 = var.tags
}

# -----------------------------
# EKS MODULE
# -----------------------------
module "eks" {
  source = "./modules/eks"

  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnets
  tags         = var.tags
}

# -----------------------------
# KARPENTER MODULE
# -----------------------------
module "karpenter" {
  source = "./modules/karpenter"

  cluster_name = module.eks.cluster_name
  tags         = var.tags
}

module "platform_addons" {
  source = "./modules/platform-addons"

  cluster_name = module.eks.cluster_name
  tags         = var.tags
}

module "payments_workload_iam" {
  source = "./modules/workload-iam"

  cluster_name         = module.eks.cluster_name
  namespace            = "payments"
  service_account_name = "payments-microservice"
  secret_arns          = var.payments_secret_arns
  tags                 = var.tags
}