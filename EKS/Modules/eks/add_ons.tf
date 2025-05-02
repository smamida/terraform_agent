resource "aws_eks_addon" "kube_proxy" {
  depends_on   = [aws_eks_cluster.this]
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "kube-proxy"
  addon_version = "v1.31.2-eksbuild.3"
  tags = {
    Environment = var.env
    Name        = "kube-proxy-Addon"
  }
}

resource "aws_eks_addon" "coredns" {
  depends_on   = [aws_eks_cluster.this]
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "coredns"
  addon_version = "v1.11.3-eksbuild.1"
  tags = {
    Environment = var.env
    Name        = "CoreDNS-Addon"
  }
}

resource "aws_eks_addon" "ebs_csi_driver" {
  depends_on = [aws_eks_cluster.this]
  cluster_name    = aws_eks_cluster.this.name
  addon_name      = "aws-ebs-csi-driver"
  addon_version   = "v1.37.0-eksbuild.1"
  tags = {
    Environment = var.env
    Name        = "EBS-CSI-Addon"
  }
}

resource "aws_eks_addon" "csi_snapshot_controller" {
  depends_on   = [aws_eks_cluster.this]
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "snapshot-controller"
  addon_version = "v8.1.0-eksbuild.2"
  tags = {
    Environment = var.env
    Name        = "EBS-CSI-Addon"
  }
}

resource "aws_eks_addon" "vpc_cni" {
  depends_on   = [aws_eks_cluster.this]
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "vpc-cni"
  addon_version = "v1.19.0-eksbuild.1"
  tags = {
    Environment = var.env
    Name        = "VPC-CNI-Addon"
  }
}
