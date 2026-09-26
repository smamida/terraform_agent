output "eks_cluster_arn" {
  description = "ARN of the environment EKS cluster."
  value       = module.infrastructure.eks_cluster_arn
}

output "eks_cluster_name" {
  description = "Name of the environment EKS cluster."
  value       = module.infrastructure.eks_cluster_name
}

output "eks_node_role_arn" {
  description = "ARN of the environment EKS node role."
  value       = module.infrastructure.eks_node_role_arn
}

output "platform_bucket_arn" { value = module.infrastructure.platform_bucket_arn }
output "platform_kms_key_arn" { value = module.infrastructure.platform_kms_key_arn }
output "platform_log_group_arn" { value = module.infrastructure.platform_log_group_arn }
output "platform_queue_arn" { value = module.infrastructure.platform_queue_arn }
output "platform_topic_arn" { value = module.infrastructure.platform_topic_arn }
output "platform_secret_arn" { value = module.infrastructure.platform_secret_arn }
