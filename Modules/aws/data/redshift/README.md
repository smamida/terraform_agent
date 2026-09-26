# Redshift

`main.tf` is a starter for an encrypted, private multi-node Redshift cluster. Master credentials are managed by AWS Secrets Manager and are not supplied as Terraform values.

The sample requires an existing private subnet group and restricted security groups. Choose node type and node count for the workload and budget; Redshift clusters can incur substantial ongoing charges. This module is not called by the repository root.