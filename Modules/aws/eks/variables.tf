variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "env" {
  type = string
}
variable "k8s_version" {

}
variable "subnet_ids" {
  type = list(string)
}
variable "security_group_ids" {
  type = list(string)
}
variable "public_access_cidrs" {
  type = list(string)
}
variable "endpoint_public_access" {
  default = true
}
variable "endpoint_private_access" {
  default = false
}

variable "enabled_cluster_log_types" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

variable "availability_zone" {
  type = string
  #default = "ap-south-1a"
}


# variable "eks_node_role_arn" {
#   description = "ARN of the IAM role for EKS nodes"
#   type        = string
# }
