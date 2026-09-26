# Terraform Environments

The repository root remains the shared Terraform root so module code is not copied into every environment. The `dev`, `test`, and `prod` folders are complete Terraform roots that call the shared stack; `qa` and `stage` retain their existing backend and variable examples. Existing root files and the current Development state location are preserved.

## Prepare an Environment

From the repository root, copy the example files for the target environment to the ignored local filenames:

```powershell
Copy-Item .\environments\dev\backend.hcl.example .\environments\dev\backend.hcl
Copy-Item .\environments\dev\terraform.tfvars.example .\environments\dev\terraform.tfvars
```

Edit the local files with the correct subnet IDs, security groups, endpoint CIDRs, state bucket, and environment values. Do not use placeholder values for a real plan.

Initialize and review a Development plan:

```powershell
terraform init -reconfigure -backend-config=environments/dev/backend.hcl
terraform plan -var-file=environments/dev/terraform.tfvars
```

For the isolated environment roots, run the commands from the environment directory:

```powershell
Set-Location .\environments\test
Copy-Item backend.hcl.example backend.hcl
Copy-Item terraform.tfvars.example terraform.tfvars
terraform init -backend-config=backend.hcl
terraform plan -var-file=terraform.tfvars
```

Use the same pattern for `dev` or `prod`; each environment must use a unique state key. Production examples are intentionally placeholders and are not deployment-ready. Review the plan and obtain human approval before applying.

The existing GitHub workflow still uses the original root `dev.tfvars` and backend. These new examples do not change CI behavior or remote state until explicitly copied and selected.