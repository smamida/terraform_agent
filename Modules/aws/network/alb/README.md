# Application Load Balancer

Starter internal ALB with an HTTP listener and IP target group. Attach targets from a consuming stack and provide restrictive security groups. If public ingress is required, explicitly review the security boundary and add an ACM-backed HTTPS listener before exposing it. Deletion protection is enabled. The sample is not called by the repository root.