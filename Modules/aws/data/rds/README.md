# RDS

`main.tf` is a starter for a private, encrypted PostgreSQL RDS instance with managed master credentials, backup retention, deletion protection, and a final snapshot. Supply an existing private DB subnet group and restrictive security groups. Multi-AZ defaults and instance sizing should be chosen for workload and budget; this module is not called by the repository root.