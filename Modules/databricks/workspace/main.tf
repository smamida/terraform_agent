variable "account_id" {
  description = "Databricks account ID used by the account-level provider."
  type        = string
}

variable "workspace_name" {
  description = "Name of the Databricks workspace."
  type        = string
}

variable "aws_region" {
  description = "AWS region for the workspace."
  type        = string
}

variable "credentials_id" {
  description = "Databricks account credential configuration ID."
  type        = string
}

variable "storage_configuration_id" {
  description = "Databricks account root storage configuration ID."
  type        = string
}

variable "network_id" {
  description = "Databricks account network configuration ID."
  type        = string
}

variable "pricing_tier" {
  description = "Workspace pricing tier selected for the account."
  type        = string
  default     = "PREMIUM"
}

resource "databricks_mws_workspaces" "this" {
  account_id               = var.account_id
  workspace_name           = var.workspace_name
  aws_region               = var.aws_region
  credentials_id           = var.credentials_id
  storage_configuration_id = var.storage_configuration_id
  network_id               = var.network_id
  pricing_tier             = var.pricing_tier
}

output "workspace_id" {
  description = "ID of the provisioned Databricks workspace."
  value       = databricks_mws_workspaces.this.workspace_id
}

output "workspace_url" {
  description = "URL of the provisioned Databricks workspace."
  value       = databricks_mws_workspaces.this.workspace_url
}