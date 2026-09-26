terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }
}

variable "name" {
  description = "Base name for the queue and topic."
  type        = string
}

variable "tags" {
  description = "Tags applied to queues and topic."
  type        = map(string)
  default     = {}
}

resource "aws_sqs_queue" "dead_letter" {
  name                      = "${var.name}-dlq"
  message_retention_seconds = 1209600
  sqs_managed_sse_enabled   = true
  tags                      = var.tags
}

resource "aws_sqs_queue" "this" {
  name                       = var.name
  visibility_timeout_seconds = 60
  message_retention_seconds  = 345600
  sqs_managed_sse_enabled    = true
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter.arn
    maxReceiveCount     = 5
  })
  tags = var.tags
}

resource "aws_sns_topic" "this" {
  name                          = "${var.name}-events"
  sqs_failure_feedback_role_arn = null
  tags                          = var.tags
}

output "queue_arn" {
  description = "ARN of the primary queue."
  value       = aws_sqs_queue.this.arn
}

output "dead_letter_queue_arn" {
  description = "ARN of the dead-letter queue."
  value       = aws_sqs_queue.dead_letter.arn
}

output "topic_arn" {
  description = "ARN of the SNS topic."
  value       = aws_sns_topic.this.arn
}