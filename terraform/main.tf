terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "./networking"
  vpc_cidr = var.vpc_cidr
}

module "iam" {
  source = "./iam"
}

module "eks" {
  source = "./eks"

  cluster_name      = var.cluster_name
  subnet_ids        = module.network.private_subnet_ids
  cluster_role_arn  = module.iam.eks_cluster_role_arn
  node_role_arn     = module.iam.eks_node_role_arn
}
module "addons" {
  source = "./addons"

  cluster_name = var.cluster_name
}

