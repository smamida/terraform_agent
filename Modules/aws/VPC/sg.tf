
# ################################################################################
# # Security Group Resources
# ################################################################################
# resource "aws_security_group" "load-balancer" {
#   name   = " terra-load-balancer"
#   vpc_id = aws_vpc.vpc.id
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     Name = "terraform_sg_LB"
#   }
# }


# # Autoscaling group - Security group
# resource "aws_security_group" "asg_security_group" {
#   vpc_id = aws_vpc.vpc.id
#   name   = "terra-asg-security_group"
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     #security_groups = [aws_security_group.load-balancer.id]
#   }
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     Name = "terraform_scaling_group"
#   }
# }