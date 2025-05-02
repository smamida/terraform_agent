variable "cluster_name" {}
variable "node_group_name" {}
variable "instance_types" { type = list(string) }
variable "desired_size" { type =  number}
variable "min_size"  { type =  number}
variable "max_size"  { type =  number}
variable "subnet_ids" { type = list(string) }
variable "tags" { type = map(string) }
variable "env" {
  
}
variable "node_group_count" {
  description = "Number of node groups to create"
  type        = number
  default     = 1
}

variable "node_group_base_name" {
  description = "Base name for the EKS node groups"
  type        = string
  default     = "eks-node-group"
}
