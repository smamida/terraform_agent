variable "aws_region" {
  description = "AWS region in which to deploy the infrastructure."
  type        = string
  default     = "ap-south-1"
}

variable "env" {
  description = "The environment for the deployment (e.g., dev, prod)."
  type        = string

  validation {
    condition     = contains(["dev", "test", "qa", "stage", "prod"], var.env)
    error_message = "env must be dev, test, qa, stage, or prod."
  }
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "k8s_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster."
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the EKS cluster."
  type        = list(string)
}

variable "enabled_cluster_log_types" {
  description = "List of enabled log types for the EKS cluster."
  type        = list(string)
}

variable "public_access_cidrs" {
  description = "CIDR blocks for public access to the EKS cluster."
  type        = list(string)
}

variable "endpoint_public_access" {
  description = "Enable public access to the EKS endpoint."
  type        = bool
}

variable "endpoint_private_access" {
  description = "Enable private access to the EKS endpoint."
  type        = bool
}

# Node Group Variables
variable "node_group_name" {
  description = "The name of the node group."
  type        = string
}

variable "instance_types" {
  description = "List of instance types for the node group."
  type        = list(string)
}

variable "desired_size" {
  description = "Desired number of nodes in the node group."
  type        = number
}

variable "min_size" {
  description = "Minimum number of nodes in the node group."
  type        = number
}

variable "max_size" {
  description = "Maximum number of nodes in the node group."
  type        = number
}

variable "availability_zone" {
  type = string
  #default = "ap-south-1a"
}
# variable "node_group_subnet_ids" {
#   description = "List of subnet IDs for the node group."
#   type        = list(string)
# }

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
}



# variables.tf
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC managed by the VPC module."
  type        = string

  validation {
    condition     = can(cidrhost(var.vpc_cidr_block, 0))
    error_message = "vpc_cidr_block must be a valid IPv4 CIDR block."
  }
}
variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets."
  type        = list(string)

  validation {
    condition = length(var.public_subnet_cidrs) == 2 && alltrue([
      for cidr in var.public_subnet_cidrs : can(cidrhost(cidr, 0))
    ])
    error_message = "Provide exactly two valid public subnet CIDR blocks."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets."
  type        = list(string)

  validation {
    condition = length(var.private_subnet_cidrs) == 2 && alltrue([
      for cidr in var.private_subnet_cidrs : can(cidrhost(cidr, 0))
    ])
    error_message = "Provide exactly two valid private subnet CIDR blocks."
  }
}
variable "availability_zones" {
  description = "Availability zones used by the two-AZ VPC module."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) == 2
    error_message = "Exactly two availability zones are required."
  }
}

variable "platform_bucket_name" {
  description = "Globally unique S3 bucket for platform artifacts."
  type        = string
}

variable "kms_alias_name" {
  description = "KMS alias suffix for environment encryption."
  type        = string
}

variable "kms_description" {
  description = "Purpose of the environment KMS key."
  type        = string
}

variable "log_group_name" {
  description = "CloudWatch log group for shared platform logs."
  type        = string
}

variable "log_retention_days" {
  description = "Number of days to retain shared platform logs."
  type        = number
  validation {
    condition     = var.log_retention_days >= 1
    error_message = "log_retention_days must be at least one day."
  }
}

variable "queue_name" {
  description = "SQS queue and SNS topic base name."
  type        = string
}

variable "secret_name" {
  description = "Secrets Manager secret container name."
  type        = string
}

variable "secret_description" {
  description = "Purpose of the Secrets Manager secret container."
  type        = string
}
