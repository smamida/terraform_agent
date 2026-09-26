terraform {
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~> 2.20"
    }
  }
}

variable "database_name" {
  description = "Name of the Snowflake database."
  type        = string
}

variable "warehouse_name" {
  description = "Name of the Snowflake virtual warehouse."
  type        = string
}

variable "warehouse_size" {
  description = "Warehouse size. X-SMALL is the smallest standard size."
  type        = string
  default     = "X-SMALL"
}

variable "auto_suspend_seconds" {
  description = "Seconds of inactivity before suspending the warehouse."
  type        = number
  default     = 60

  validation {
    condition     = var.auto_suspend_seconds >= 1
    error_message = "auto_suspend_seconds must be at least 1."
  }
}

variable "comment" {
  description = "Description applied to the database and warehouse."
  type        = string
}

resource "snowflake_database" "this" {
  name                        = var.database_name
  comment                     = var.comment
  data_retention_time_in_days = 1
}

resource "snowflake_warehouse" "this" {
  name                = var.warehouse_name
  warehouse_size      = var.warehouse_size
  auto_suspend        = var.auto_suspend_seconds
  auto_resume         = "true"
  initially_suspended = true
  comment             = var.comment
}

output "database_fully_qualified_name" {
  description = "Fully qualified Snowflake database name."
  value       = snowflake_database.this.fully_qualified_name
}

output "warehouse_fully_qualified_name" {
  description = "Fully qualified Snowflake warehouse name."
  value       = snowflake_warehouse.this.fully_qualified_name
}