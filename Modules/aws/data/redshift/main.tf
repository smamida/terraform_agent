terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }
}

variable "cluster_identifier" {
  description = "Unique identifier for the Redshift cluster."
  type        = string
}

variable "database_name" {
  description = "Initial database name."
  type        = string
}

variable "master_username" {
  description = "Initial database administrator username."
  type        = string
}

variable "node_type" {
  description = "Redshift node type selected for the workload and budget."
  type        = string
}

variable "number_of_nodes" {
  description = "Number of nodes in the multi-node cluster."
  type        = number

  validation {
    condition     = var.number_of_nodes >= 2
    error_message = "A multi-node Redshift cluster requires at least two nodes."
  }
}

variable "cluster_subnet_group_name" {
  description = "Name of an existing private Redshift subnet group."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Security groups restricted to approved database clients."
  type        = list(string)
}

variable "kms_key_id" {
  description = "Optional customer-managed KMS key for cluster and admin secret encryption."
  type        = string
  default     = null
}

variable "iam_role_arns" {
  description = "IAM roles Redshift may assume for explicitly approved integrations."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags applied to the cluster."
  type        = map(string)
  default     = {}
}

resource "aws_redshift_cluster" "this" {
  cluster_identifier                  = var.cluster_identifier
  database_name                       = var.database_name
  master_username                     = var.master_username
  manage_master_password              = true
  master_password_secret_kms_key_id   = var.kms_key_id
  node_type                           = var.node_type
  cluster_type                        = "multi-node"
  number_of_nodes                     = var.number_of_nodes
  cluster_subnet_group_name           = var.cluster_subnet_group_name
  vpc_security_group_ids              = var.vpc_security_group_ids
  iam_roles                           = var.iam_role_arns
  encrypted                           = true
  kms_key_id                          = var.kms_key_id
  publicly_accessible                 = false
  enhanced_vpc_routing                = true
  automated_snapshot_retention_period = 7
  skip_final_snapshot                 = false
  final_snapshot_identifier           = "${var.cluster_identifier}-final"
  tags                                = var.tags
}

output "cluster_arn" {
  description = "ARN of the Redshift cluster."
  value       = aws_redshift_cluster.this.arn
}

output "endpoint" {
  description = "Private endpoint and port of the Redshift cluster."
  value       = aws_redshift_cluster.this.endpoint
}