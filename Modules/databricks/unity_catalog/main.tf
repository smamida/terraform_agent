variable "catalog_name" {
  description = "Name of the Unity Catalog catalog."
  type        = string
}

variable "storage_root" {
  description = "Governed storage root URI for the catalog."
  type        = string
}

variable "comment" {
  description = "Description of the catalog's purpose."
  type        = string
}

resource "databricks_catalog" "this" {
  name          = var.catalog_name
  storage_root  = var.storage_root
  comment       = var.comment
  force_destroy = false
}

output "catalog_name" {
  description = "Name of the Unity Catalog catalog."
  value       = databricks_catalog.this.name
}