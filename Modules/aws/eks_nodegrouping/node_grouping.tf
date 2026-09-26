resource "aws_eks_node_group" "this" {
  count           = var.node_group_count
  cluster_name    = var.cluster_name
  node_group_name = format("%s-%s-%d", var.node_group_base_name, var.env, count.index + 1)

  # node_group_name = format("%s%d", var.node_group_base_name, count.index + 1)#var.node_group_name
  node_role_arn  = aws_iam_role.eks_node.arn
  subnet_ids     = var.subnet_ids
  instance_types = var.instance_types
  ami_type       = "AL2_x86_64"
  #   remote_access {
  #   ec2_ssh_key = "eks-terraform-key"
  # }

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }


  depends_on = [
    aws_iam_role_policy_attachment.aws_managed,
    aws_iam_role_policy_attachment.eks_cni,
    aws_iam_role_policy_attachment.ecr_readonly,
    aws_iam_role_policy_attachment.ssm
  ]
  tags = {
    Environment = var.env
    Name        = "eks-node-group-${var.env}"
  }
}

#   tags = merge(
#     var.tags,
#     {
#       "Name" = "EKS-Node-${var.node_group_name}"  # Adding a Name tag for the instances
#     }
#   )
# }
