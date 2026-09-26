terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }
}

variable "name" {
  description = "Name for the Secrets Manager secret."
  type        = string
}

variable "description" {
  description = "Description of the secret's purpose."
  type        = string
}

variable "kms_key_id" {
  description = "Optional customer-managed KMS key ID."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to the secret metadata."
  type        = map(string)
  default     = {}
}

resource "aws_secretsmanager_secret" "this" {
  name                    = var.name
  description             = var.description
  kms_key_id              = var.kms_key_id
  recovery_window_in_days = 30
  tags                    = var.tags
}

output "secret_arn" {
  description = "ARN of the secret container. No secret value is read or output."
  value       = aws_secretsmanager_secret.this.arn
}