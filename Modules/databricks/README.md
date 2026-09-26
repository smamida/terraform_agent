# Databricks Modules

Databricks samples are kept separate from AWS service modules because they use the Databricks provider and may target account-level or workspace-level APIs. They are not called by the active root stack; no workspace or billable resources are created unless explicitly connected and applied.