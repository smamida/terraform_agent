output cluster_arn {
  value = aws_eks_cluster.this.arn
}

output cluster_id {
  value = aws_eks_cluster.this.id
}

output "cluster_name" {
  value = aws_eks_cluster.this.name
}