terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }
}

variable "alias_name" {
  description = "KMS alias suffix; do not include the alias/ prefix."
  type        = string
}

variable "description" {
  description = "Purpose of the customer-managed key."
  type        = string
}

variable "tags" {
  description = "Tags applied to the key."
  type        = map(string)
  default     = {}
}

resource "aws_kms_key" "this" {
  description             = var.description
  enable_key_rotation     = true
  deletion_window_in_days = 30
  tags                    = var.tags
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.alias_name}"
  target_key_id = aws_kms_key.this.key_id
}

output "key_arn" {
  description = "ARN of the customer-managed KMS key."
  value       = aws_kms_key.this.arn
}