resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.k8s_version

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = var.security_group_ids
    public_access_cidrs     = var.public_access_cidrs
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
  }
  enabled_cluster_log_types = var.enabled_cluster_log_types
  tags                      = var.tags
}


resource "kubernetes_config_map" "aws_auth" {
  depends_on = [aws_eks_cluster.this]

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = jsonencode([
      {
        rolearn  = aws_iam_role.eks_cluster.arn
        username = "eks-admin"
        groups   = ["system:masters"]
      },
      {
        # rolearn  = "arn:aws:iam::025066239748:role/AWSReservedSSO_RestrictedAdmin_8caf7ff8d9e27f19"
        role_arn =  "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_RestrictedAdmin_8caf7ff8d9e27f19"
        username = "additional-user"
        groups   = ["system:masters"]
      }
    ])
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [data]
  }
}
# resource "aws_ebs_volume" "my_ebs_volume" {
#   availability_zone = var.availability_zone #data.aws_availability_zones.available.names[0]
#   size              = 10  
#   type              = "gp3" #gp3
#   tags = {
#     Name = "my-ebs-volume"
#   }
# }

# resource "kubernetes_storage_class" "ebs_storage_class" {
#   metadata {
#     name = "ebs-storage-class"
#   }
#   storage_provisioner = "ebs.csi.aws.com" 
#   # parameters = {
#   #   type = "gp3" #gp3
#   # } #opt 
#   reclaim_policy      = "Retain"
#   # allow_volume_expansion = "true" 
#   volume_binding_mode = "Immediate" #"WaitForFirstConsumer" 
# }

# resource "kubernetes_persistent_volume" "example" {
#   metadata {
#     name = "examplevolumename"
#   }
#   spec {
#     capacity = {
#       storage = "10Gi"
#     }
#     access_modes = ["ReadWriteOnce"]
#     storage_class_name = kubernetes_storage_class.ebs_storage_class.metadata[0].name
#     persistent_volume_source {
#       aws_elastic_block_store {
#         volume_id = aws_ebs_volume.my_ebs_volume.id
#         fs_type   = "ext4"
#       }
#     }
#   }
# }

# resource "kubernetes_persistent_volume_claim" "example" {
#    depends_on = [
#     kubernetes_persistent_volume.example,
#     aws_ebs_volume.my_ebs_volume,
#     kubernetes_storage_class.ebs_storage_class
#   ]
#   metadata {
#     name = "exampleclaimname"
#   }
#   spec {
#     storage_class_name = kubernetes_storage_class.ebs_storage_class.metadata[0].name
#     #storage_class_name = "example-storage-class"
#     access_modes = ["ReadWriteOnce"]
#     resources {
#       requests = {
#         storage = "10Gi"
#       }
#     }
#    # volume_name = "${kubernetes_persistent_volume.example.metadata.0.name}"
#   }
# }

# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.main.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.main.token

# #   exec {
# #     api_version = "client.authentication.k8s.io/v1beta1"
# #     command     = "aws"
# #     args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.main.name]
# #   }
#  }

# # AWS EKS cluster data source
# data "aws_eks_cluster" "main" {
#   name = aws_eks_cluster.this.name
# }

# # AWS EKS cluster authentication data source
# data "aws_eks_cluster_auth" "main" {
#   name = aws_eks_cluster.this.name
# }



# data "aws_availability_zones" "available" {}

# data "aws_caller_identity" "current" {}

