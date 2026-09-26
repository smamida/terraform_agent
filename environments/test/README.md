# Test Environment

This root calls the shared Terraform stack in `../../` with Test-specific inputs.

Copy `backend.hcl.example` and `terraform.tfvars.example` to the ignored local filenames, replace all placeholders, then run from this directory:

```powershell
terraform init -backend-config=backend.hcl
terraform plan -var-file=terraform.tfvars
```

Review the plan before applying. Never commit backend credentials or real variable files.
