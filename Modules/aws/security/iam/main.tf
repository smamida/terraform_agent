terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }
}

variable "role_name" {
  description = "Name for the IAM role."
  type        = string
}

variable "service_principal" {
  description = "AWS service allowed to assume this role."
  type        = string
}

variable "policy_actions" {
  description = "Actions required by the workload. Keep this list narrowly scoped."
  type        = list(string)
}

variable "policy_resource_arns" {
  description = "Resource ARNs the workload must access. Avoid wildcard resources."
  type        = list(string)
}

resource "aws_iam_role" "this" {
  name = var.role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = var.service_principal
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "this" {
  name = "${var.role_name}-inline"
  role = aws_iam_role.this.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = var.policy_actions
      Resource = var.policy_resource_arns
    }]
  })
}

output "role_arn" {
  description = "ARN of the workload IAM role."
  value       = aws_iam_role.this.arn
}