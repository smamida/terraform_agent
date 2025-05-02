provider "aws" {
  region = "ap-south-1"
}

# terraform {
#   required_providers {
#     kubernetes = {
#       source  = "hashicorp/kubernetes"
#       version = ">= 2.16.1" # Replace with the latest stable version
#     }
#   }
# }

module "eks" {
  source                    = "./Modules/eks"
  env                       = var.env
  cluster_name              = var.cluster_name
  k8s_version               = var.k8s_version
  subnet_ids                = var.subnet_ids
  security_group_ids        = var.security_group_ids
  enabled_cluster_log_types = var.enabled_cluster_log_types
  public_access_cidrs       = var.public_access_cidrs
  endpoint_public_access    = var.endpoint_public_access
  endpoint_private_access   = var.endpoint_private_access
  availability_zone         = var.availability_zone

  tags = var.tags
}

module "eks_nodegroup" {
  source          = "./Modules/eks_nodegrouping"
  env             = var.env
  cluster_name    = module.eks.cluster_name # aws_eks_cluster.this.name #module.aws_eks_cluster_name
  node_group_name = var.node_group_name
  instance_types  = var.instance_types
  desired_size    = var.desired_size
  min_size        = var.min_size
  max_size        = var.max_size
  subnet_ids      = var.subnet_ids #["subnet-065800cb667115781","subnet-0597e69946478cccf"]#["subnet-0681aafb825816409", "subnet-0dbefe1a726213995"]
  tags            = var.tags
}

