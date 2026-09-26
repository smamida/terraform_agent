# Terraform EKS Infrastructure

This repository contains Terraform modules for an AWS EKS cluster, managed node group, VPC, and Kubernetes resources.

## Layout

- Root Terraform files configure providers, remote state, environment inputs, and module composition.
- `Modules/eks/` manages the EKS control plane and cluster-side resources.
- `Modules/eks_nodegrouping/` manages the worker node group and its IAM role.
- `Modules/VPC/` manages a two-AZ VPC, public/private subnets, and routing.
- `Modules/aws/` contains sample modules for MWAA, Glue, S3, EC2, security groups, ALB, Secrets Manager, API Gateway, IAM, KMS, Lambda, RDS, Redshift, SQS/SNS, and CloudWatch.
- `Modules/databricks/` contains sample modules for workspaces, Unity Catalog, and jobs.
- `Modules/snowflake/` contains Terraform examples for Snowflake platform resources.
- `Modules/dbt/` contains a dbt project starter targeting Snowflake.
- `environments/` contains additive `dev`, `test`, `qa`, `stage`, and `prod` roots. The `dev`, `test`, and `prod` roots call the shared stack from `../../` and keep backend and variable examples alongside each environment. They do not replace the current root `dev.tfvars` or change the active state configuration.
- `dev.tfvars` contains Development inputs. `prod.tfvars` is currently empty.

AWS, Databricks, and Snowflake samples are not called by the active root stack and will not create infrastructure unless explicitly connected and applied. The dbt project is run separately from its own directory. Its profile is an example only; local `profiles.yml` files are ignored by Git so credentials are not committed.

## Workflow

Pull requests and pushes to `main` run formatting, initialization without remote state, and validation; they do not apply infrastructure.

To deploy Development, manually dispatch the `Terraform CI/CD` workflow. Configure the GitHub `Development` environment with an `AWS_ROLE_ARN` variable and an AWS OIDC trust policy for this repository. The workflow plans and applies the same saved plan using `dev.tfvars`.

The S3 backend retains its existing bucket and key and uses native state lockfiles. Ensure the bucket has versioning enabled and access is restricted to the CI role and authorized operators.

## Production Readiness

Production deployment is not enabled: `prod.tfvars` has no values, and Production needs an isolated state key plus a protected GitHub environment.

The root currently creates a VPC, but EKS consumes subnet and security-group IDs from `dev.tfvars`. Decide whether the stack owns the EKS network or uses an externally managed VPC before changing that wiring; changing subnet assignments can update or replace EKS resources.

The Development EKS API currently allows `0.0.0.0/0`. Replace it with trusted CIDR ranges before deployment. The Kubernetes provider also runs from the GitHub-hosted runner, so private-only endpoint access requires a runner with network access to the VPC.
