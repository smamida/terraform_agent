variable "aws_region" {
  type        = string
  description = "AWS region for this environment."
}

variable "env" {
  type        = string
  description = "Environment name."
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}

variable "k8s_version" {
  type        = string
  description = "Kubernetes version."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets used by the EKS cluster and node group."
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security groups used by the EKS cluster."
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  description = "EKS control-plane log types."
}

variable "public_access_cidrs" {
  type        = list(string)
  description = "CIDR blocks allowed to reach the public EKS endpoint."
}

variable "endpoint_public_access" {
  type        = bool
  description = "Whether the EKS endpoint is publicly accessible."
}

variable "endpoint_private_access" {
  type        = bool
  description = "Whether the EKS endpoint is privately accessible."
}

variable "availability_zone" {
  type        = string
  description = "Primary availability zone."
}

variable "node_group_name" {
  type        = string
  description = "EKS managed node group name."
}

variable "instance_types" {
  type        = list(string)
  description = "EC2 instance types for the node group."
}

variable "desired_size" {
  type        = number
  description = "Desired node count."
}

variable "min_size" {
  type        = number
  description = "Minimum node count."
}

variable "max_size" {
  type        = number
  description = "Maximum node count."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to resources."
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block."
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDR blocks."
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDR blocks."
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones for the VPC."
}

variable "platform_bucket_name" { type = string }
variable "kms_alias_name" { type = string }
variable "kms_description" { type = string }
variable "log_group_name" { type = string }
variable "log_retention_days" { type = number }
variable "queue_name" { type = string }
variable "secret_name" { type = string }
variable "secret_description" { type = string }
