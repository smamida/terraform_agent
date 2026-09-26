terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }
}

variable "function_name" {
  description = "Name of the Lambda function."
  type        = string
}

variable "package_path" {
  description = "Path to a prebuilt deployment ZIP file."
  type        = string
}

variable "role_arn" {
  description = "ARN of the execution role with least-privilege permissions."
  type        = string
}

variable "runtime" {
  description = "Supported Lambda runtime."
  type        = string
}

variable "handler" {
  description = "Function handler entry point."
  type        = string
}

resource "aws_lambda_function" "this" {
  function_name    = var.function_name
  filename         = var.package_path
  source_code_hash = filebase64sha256(var.package_path)
  role             = var.role_arn
  runtime          = var.runtime
  handler          = var.handler
  memory_size      = 256
  timeout          = 30
  publish          = true
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 90
}

output "function_arn" {
  description = "ARN of the Lambda function."
  value       = aws_lambda_function.this.arn
}