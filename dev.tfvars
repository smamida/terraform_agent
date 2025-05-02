#eks
env                       = "dev"
cluster_name              = "gilead-emqx-eks-cluster"
k8s_version               = "1.31"
subnet_ids                = ["subnet-0754a03477fb5cd4e", "subnet-02c8a5d54d2e7ede8"]
security_group_ids        = ["sg-0d14bf339f3d56ebf"]
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


