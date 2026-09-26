provider "aws" {
  region = var.aws_region
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
  source                    = "./Modules/aws/eks"
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

  tags = local.common_tags
}

module "eks_nodegroup" {
  source          = "./Modules/aws/eks_nodegrouping"
  env             = var.env
  cluster_name    = module.eks.cluster_name # aws_eks_cluster.this.name #module.aws_eks_cluster_name
  node_group_name = var.node_group_name
  instance_types  = var.instance_types
  desired_size    = var.desired_size
  min_size        = var.min_size
  max_size        = var.max_size
  subnet_ids      = var.subnet_ids #["subnet-065800cb667115781","subnet-0597e69946478cccf"]#["subnet-0681aafb825816409", "subnet-0dbefe1a726213995"]
  tags            = local.common_tags
}
module "vpc" {
  source               = "./Modules/aws/VPC"
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "platform_kms" {
  source      = "./Modules/aws/security/kms"
  alias_name  = var.kms_alias_name
  description = var.kms_description
  tags        = local.common_tags
}

module "platform_bucket" {
  source      = "./Modules/aws/storage/s3"
  bucket_name = var.platform_bucket_name
  tags        = local.common_tags
}

module "platform_logs" {
  source         = "./Modules/aws/observability/cloudwatch"
  log_group_name = var.log_group_name
  retention_days = var.log_retention_days
  kms_key_arn    = module.platform_kms.key_arn
  tags           = local.common_tags
}

module "platform_queue" {
  source = "./Modules/aws/messaging/sqs_sns"
  name   = var.queue_name
  tags   = local.common_tags
}

module "platform_secret" {
  source      = "./Modules/aws/security/secrets_manager"
  name        = var.secret_name
  description = var.secret_description
  kms_key_id  = module.platform_kms.key_arn
  tags        = local.common_tags
}