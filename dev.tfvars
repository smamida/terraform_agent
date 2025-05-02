#eks
env                       = "dev"
cluster_name              = "gilead-emqx-eks-cluster"
k8s_version               = "1.31"
subnet_ids                = ["subnet-028a6369ffc3eba74", "subnet-05733f91ba1be9c97"]
security_group_ids        = ["sg-03917cf74c8b8025d"]
enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
public_access_cidrs       = ["0.0.0.0/0"]
endpoint_public_access    = true

endpoint_private_access = false
availability_zone       = "ap-south-1a"
#vpc_id                    = "vpc-0d38241b7910def2a"

#node_grouping 
node_group_name = "Emqx-nodegroup"
instance_types  = ["t3.medium"]
desired_size    = 1
min_size        = 1
max_size        = 5
tags = {
  "Environment" = "dev"
  "Project"     = "test-project"
}


# dev.tfvars
vpc_cidr_block       = "10.0.0.0/16"
availability_zones   = ["ap-south-1a", "ap-south-1b"]

public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
