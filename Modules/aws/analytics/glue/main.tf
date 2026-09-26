terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }
}

variable "name" {
  description = "Name of the Glue job."
  type        = string
}

variable "role_arn" {
  description = "ARN of the job role with access limited to required data and logs."
  type        = string
}

variable "script_location" {
  description = "S3 URI for the versioned Glue job script."
  type        = string
}

variable "glue_version" {
  description = "Supported AWS Glue runtime version."
  type        = string
}

variable "tags" {
  description = "Tags applied to the Glue job."
  type        = map(string)
  default     = {}
}

resource "aws_glue_job" "this" {
  name              = var.name
  role_arn          = var.role_arn
  glue_version      = var.glue_version
  worker_type       = "G.1X"
  number_of_workers = 2
  timeout           = 60
  max_retries       = 1
  tags              = var.tags

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = var.script_location
  }

  execution_property {
    max_concurrent_runs = 1
  }

  default_arguments = {
    "--job-language"                     = "python"
    "--enable-metrics"                   = "true"
    "--enable-continuous-cloudwatch-log" = "true"
  }
}

output "job_name" {
  description = "Name of the Glue job."
  value       = aws_glue_job.this.name
}