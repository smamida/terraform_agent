terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }
}

variable "name" {
  description = "Unique MWAA environment name."
  type        = string
}

variable "airflow_version" {
  description = "Supported Amazon MWAA Airflow version."
  type        = string
}

variable "execution_role_arn" {
  description = "ARN of the least-privilege MWAA execution role."
  type        = string
}

variable "source_bucket_arn" {
  description = "ARN of the private S3 bucket containing DAGs and plugins."
  type        = string
}

variable "dag_s3_path" {
  description = "Object key prefix for DAG files."
  type        = string
}

variable "subnet_ids" {
  description = "Two private subnet IDs in separate availability zones."
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) == 2
    error_message = "MWAA requires exactly two subnet IDs."
  }
}

variable "security_group_ids" {
  description = "Security groups allowing required MWAA intra-environment traffic."
  type        = list(string)
}

variable "tags" {
  description = "Tags applied to the MWAA environment."
  type        = map(string)
  default     = {}
}

resource "aws_mwaa_environment" "this" {
  name                            = var.name
  airflow_version                 = var.airflow_version
  environment_class               = "mw1.small"
  execution_role_arn              = var.execution_role_arn
  source_bucket_arn               = var.source_bucket_arn
  dag_s3_path                     = var.dag_s3_path
  min_workers                     = 1
  max_workers                     = 3
  webserver_access_mode           = "PRIVATE_ONLY"
  weekly_maintenance_window_start = "SUN:03:00"
  tags                            = var.tags

  network_configuration {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  logging_configuration {
    dag_processing_logs {
      enabled   = true
      log_level = "INFO"
    }
    scheduler_logs {
      enabled   = true
      log_level = "INFO"
    }
    task_logs {
      enabled   = true
      log_level = "INFO"
    }
    webserver_logs {
      enabled   = true
      log_level = "WARNING"
    }
    worker_logs {
      enabled   = true
      log_level = "INFO"
    }
  }
}

output "environment_arn" {
  description = "ARN of the MWAA environment."
  value       = aws_mwaa_environment.this.arn
}