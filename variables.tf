variable "env" {
  description = "The environment for the deployment (e.g., dev, prod)."
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "k8s_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster."
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the EKS cluster."
  type        = list(string)
}

variable "enabled_cluster_log_types" {
  description = "List of enabled log types for the EKS cluster."
  type        = list(string)
}

variable "public_access_cidrs" {
  description = "CIDR blocks for public access to the EKS cluster."
  type        = list(string)
}

variable "endpoint_public_access" {
  description = "Enable public access to the EKS endpoint."
  type        = bool
}

variable "endpoint_private_access" {
  description = "Enable private access to the EKS endpoint."
  type        = bool
}

# Node Group Variables
variable "node_group_name" {
  description = "The name of the node group."
  type        = string
}

variable "instance_types" {
  description = "List of instance types for the node group."
  type        = list(string)
}

variable "desired_size" {
  description = "Desired number of nodes in the node group."
  type        = number
}

variable "min_size" {
  description = "Minimum number of nodes in the node group."
  type        = number
}

variable "max_size" {
  description = "Maximum number of nodes in the node group."
  type        = number
}

variable "availability_zone" {
  type = string
  #default = "ap-south-1a"
}
# variable "node_group_subnet_ids" {
#   description = "List of subnet IDs for the node group."
#   type        = list(string)
# }

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
}

