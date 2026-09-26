# AWS Service Modules

Service-specific AWS module samples live under this directory, grouped by domain: analytics, API, compute (EC2 and Lambda), data, messaging, network (ALB and security groups), observability, security, and storage. They are not called by the active root stack, so they do not create resources unless explicitly connected and applied. Existing EKS and VPC module paths remain unchanged to avoid disrupting current module references.

Each module should define typed inputs, explicit outputs, secure defaults, resource tags, and focused validation. Secrets must be read from a secret store rather than embedded in Terraform configuration or outputs.