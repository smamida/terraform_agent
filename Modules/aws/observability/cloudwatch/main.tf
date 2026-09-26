terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }
}

variable "log_group_name" {
  description = "Name of the CloudWatch Logs group."
  type        = string
}

variable "retention_days" {
  description = "Number of days to retain log events."
  type        = number
  default     = 90
}

variable "kms_key_arn" {
  description = "Optional KMS key ARN for encrypting log data."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to the log group."
  type        = map(string)
  default     = {}
}

resource "aws_cloudwatch_log_group" "this" {
  name              = var.log_group_name
  retention_in_days = var.retention_days
  kms_key_id        = var.kms_key_arn
  tags              = var.tags
}

output "log_group_arn" {
  description = "ARN of the CloudWatch log group."
  value       = aws_cloudwatch_log_group.this.arn
}