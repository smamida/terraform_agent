# Security Group

Starter VPC security group with no implicit ingress or egress rules. Pass only explicit IPv4 CIDR rules needed by the workload. For production, consider using separate ingress/egress rule resources and source security-group references when those better express trust boundaries. The sample is not called by the repository root.