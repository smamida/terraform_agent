variable "job_name" {
  description = "Name of the Databricks job."
  type        = string
}

variable "existing_cluster_id" {
  description = "ID of an existing cluster governed by a cluster policy."
  type        = string
}

variable "notebook_path" {
  description = "Workspace path of the notebook task."
  type        = string
}

resource "databricks_job" "this" {
  name                = var.job_name
  max_concurrent_runs = 1

  task {
    task_key            = "notebook"
    existing_cluster_id = var.existing_cluster_id

    notebook_task {
      notebook_path = var.notebook_path
    }
  }
}

output "job_id" {
  description = "ID of the Databricks job."
  value       = databricks_job.this.id
}