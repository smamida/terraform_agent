terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }
}

variable "name" {
  description = "ALB and target group name; 1-32 letters, numbers, or hyphens."
  type        = string

  validation {
    condition     = length(var.name) <= 32 && can(regex("^[A-Za-z0-9][A-Za-z0-9-]*$", var.name))
    error_message = "name must be 1-32 characters and contain only letters, numbers, and hyphens."
  }
}

variable "internal" {
  description = "Whether the load balancer is internal. Keep true unless internet ingress is explicitly required."
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = "Subnet IDs for the load balancer, normally in at least two availability zones."
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "An ALB requires subnets in at least two availability zones."
  }
}

variable "security_group_ids" {
  description = "Security groups restricting client access to the ALB."
  type        = list(string)

  validation {
    condition     = length(var.security_group_ids) > 0
    error_message = "Attach at least one security group to the ALB."
  }
}

variable "vpc_id" {
  description = "VPC ID for the target group."
  type        = string
}

variable "target_port" {
  description = "Backend service port."
  type        = number
  default     = 80
}

variable "health_check_path" {
  description = "HTTP path used for target health checks."
  type        = string
  default     = "/health"
}

variable "tags" {
  description = "Tags applied to the ALB and target group."
  type        = map(string)
  default     = {}
}

resource "aws_lb" "this" {
  name                       = var.name
  internal                   = var.internal
  load_balancer_type         = "application"
  subnets                    = var.subnet_ids
  security_groups            = var.security_group_ids
  drop_invalid_header_fields = true
  enable_deletion_protection = true
  tags                       = var.tags
}

resource "aws_lb_target_group" "this" {
  name        = var.name
  port        = var.target_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  tags        = var.tags

  health_check {
    enabled             = true
    protocol            = "HTTP"
    path                = var.health_check_path
    matcher             = "200-399"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
    timeout             = 5
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

output "load_balancer_arn" {
  description = "ARN of the application load balancer."
  value       = aws_lb.this.arn
}

output "dns_name" {
  description = "DNS name of the application load balancer."
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "ARN of the target group to attach targets to."
  value       = aws_lb_target_group.this.arn
}