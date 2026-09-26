terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }
}

variable "name" {
  description = "Name of the security group."
  type        = string
}

variable "description" {
  description = "Purpose of the security group."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID that owns the security group."
  type        = string
}

variable "ingress_rules" {
  description = "Named ingress rules. Empty by default; explicitly allow only required sources."
  type = map(object({
    description = string
    protocol    = string
    from_port   = number
    to_port     = number
    cidr_blocks = list(string)
  }))
  default = {}

  validation {
    condition = alltrue(flatten([
      for rule in values(var.ingress_rules) : [
        length(rule.cidr_blocks) > 0,
        alltrue([for cidr in rule.cidr_blocks : can(cidrhost(cidr, 0))])
      ]
    ]))
    error_message = "Ingress rules must include valid IPv4 CIDR blocks."
  }
}

variable "egress_rules" {
  description = "Named egress rules. Empty by default to avoid implicit outbound access."
  type = map(object({
    description = string
    protocol    = string
    from_port   = number
    to_port     = number
    cidr_blocks = list(string)
  }))
  default = {}

  validation {
    condition = alltrue(flatten([
      for rule in values(var.egress_rules) : [
        length(rule.cidr_blocks) > 0,
        alltrue([for cidr in rule.cidr_blocks : can(cidrhost(cidr, 0))])
      ]
    ]))
    error_message = "Egress rules must include valid IPv4 CIDR blocks."
  }
}

variable "tags" {
  description = "Tags applied to the security group."
  type        = map(string)
  default     = {}
}

resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      protocol    = ingress.value.protocol
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      description = egress.value.description
      protocol    = egress.value.protocol
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = merge(var.tags, {
    Name = var.name
  })
}

output "security_group_id" {
  description = "ID of the security group."
  value       = aws_security_group.this.id
}

output "security_group_arn" {
  description = "ARN of the security group."
  value       = aws_security_group.this.arn
}