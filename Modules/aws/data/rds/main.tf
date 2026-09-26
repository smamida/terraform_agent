terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }
}

variable "identifier" {
  description = "Unique DB instance identifier."
  type        = string
}

variable "engine_version" {
  description = "Supported database engine version."
  type        = string
}

variable "master_username" {
  description = "Database master username. The password is managed by RDS."
  type        = string
}

variable "db_subnet_group_name" {
  description = "Name of an existing private DB subnet group."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Security groups allowing only required application access."
  type        = list(string)
}

variable "kms_key_id" {
  description = "Optional customer-managed KMS key ID for database and credentials encryption."
  type        = string
  default     = null
}

resource "aws_db_instance" "this" {
  identifier                    = var.identifier
  engine                        = "postgres"
  engine_version                = var.engine_version
  instance_class                = "db.t4g.micro"
  allocated_storage             = 20
  max_allocated_storage         = 100
  username                      = var.master_username
  manage_master_user_password   = true
  master_user_secret_kms_key_id = var.kms_key_id
  db_subnet_group_name          = var.db_subnet_group_name
  vpc_security_group_ids        = var.vpc_security_group_ids
  storage_encrypted             = true
  kms_key_id                    = var.kms_key_id
  publicly_accessible           = false
  multi_az                      = true
  backup_retention_period       = 7
  deletion_protection           = true
  skip_final_snapshot           = false
  final_snapshot_identifier     = "${var.identifier}-final"
}

output "db_instance_arn" {
  description = "ARN of the RDS instance."
  value       = aws_db_instance.this.arn
}