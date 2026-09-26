terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }
}

variable "name" {
  description = "Name tag and Name value for the instance."
  type        = string
}

variable "ami_id" {
  description = "Approved AMI ID for the instance."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type selected for the workload."
  type        = string
}

variable "subnet_id" {
  description = "Subnet in which to launch the instance."
  type        = string
}

variable "security_group_ids" {
  description = "Security groups attached to the instance."
  type        = list(string)

  validation {
    condition     = length(var.security_group_ids) > 0
    error_message = "Attach at least one security group to the instance."
  }
}

variable "iam_instance_profile" {
  description = "Optional existing least-privilege IAM instance profile name."
  type        = string
  default     = null
}

variable "root_volume_size_gib" {
  description = "Encrypted gp3 root volume size in GiB."
  type        = number
  default     = 30

  validation {
    condition     = var.root_volume_size_gib >= 8
    error_message = "The root volume must be at least 8 GiB."
  }
}

variable "kms_key_id" {
  description = "Optional customer-managed KMS key ID for the root volume."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to the EC2 instance and root volume."
  type        = map(string)
  default     = {}
}

resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  iam_instance_profile        = var.iam_instance_profile
  associate_public_ip_address = false
  monitoring                  = true
  ebs_optimized               = true

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  root_block_device {
    encrypted   = true
    kms_key_id  = var.kms_key_id
    volume_type = "gp3"
    volume_size = var.root_volume_size_gib
  }

  tags = merge(var.tags, {
    Name = var.name
  })
}

output "instance_id" {
  description = "ID of the EC2 instance."
  value       = aws_instance.this.id
}

output "private_ip" {
  description = "Private IP address of the EC2 instance."
  value       = aws_instance.this.private_ip
}