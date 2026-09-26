output "eks_cluster_arn" {
  description = "ARN of the EKS cluster."
  value       = module.eks.cluster_arn
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "eks_node_role_arn" {
  description = "ARN of the EKS managed node group role."
  value       = module.eks_nodegroup.eks_node_role_arn
}

output "platform_bucket_arn" {
  description = "ARN of the environment platform bucket."
  value       = module.platform_bucket.bucket_arn
}

output "platform_kms_key_arn" {
  description = "ARN of the environment platform KMS key."
  value       = module.platform_kms.key_arn
}

output "platform_log_group_arn" {
  description = "ARN of the shared platform log group."
  value       = module.platform_logs.log_group_arn
}

output "platform_queue_arn" {
  description = "ARN of the environment SQS queue."
  value       = module.platform_queue.queue_arn
}

output "platform_topic_arn" {
  description = "ARN of the environment SNS topic."
  value       = module.platform_queue.topic_arn
}

output "platform_secret_arn" {
  description = "ARN of the environment secret container."
  value       = module.platform_secret.secret_arn
}