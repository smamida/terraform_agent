
# ##############################
# ## EC2
# ###############################
# resource "aws_launch_template" "web" {
#   name          = "terra-instance"
#   image_id      = data.aws_ami.ubuntu.id
#   instance_type = "t3.micro"
#   user_data = base64encode(<<-EOF
#     #!/bin/bash
#     set -x  # Enable debugging
#     sudo apt update -y
#     sudo apt install -y nginx
#     echo "Hello from $(hostname -I)" > /var/www/html/index.html
#     systemctl start nginx
#     systemctl enable nginx
#   EOF
#   )
#   #user_data     = base64encode("#!/bin/bash\nsudo apt update -y && sudo apt install nginx -y && echo $(hostname -I) > /var/www/html/index.html")

#   network_interfaces {
#     security_groups = [aws_security_group.asg_security_group.id]
#     # associate_public_ip_address = true
#   }
# }

# data "aws_ami" "ubuntu" {
#   most_recent = true
#   owners      = ["099720109477"]
#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
#   }
# }

# ##############################
# ## Autoscaling Group Resources
# ###############################

# resource "aws_autoscaling_group" "asg" {
#   name                = "asg"
#   vpc_zone_identifier = [aws_subnet.private_1.id, aws_subnet.private_2.id, aws_subnet.public_1.id, aws_subnet.public_2.id]
#   desired_capacity    = 2
#   max_size            = 3
#   min_size            = 2
#   health_check_type   = "EC2"

#   launch_template {
#     id      = aws_launch_template.web.id
#     version = aws_launch_template.web.latest_version
#     #"$Latest" # You can also specify an exact version here if needed
#   }

#   target_group_arns = [aws_lb_target_group.asg_target.arn] # Uncomment and set this if using a target group with ALB/NLB


# }
# # resource "aws_autoscaling_attachment" "asg_attachment" {
# #   autoscaling_group_name = aws_autoscaling_group.asg.name
# #  # target_group_arn       = aws_lb_target_group.asg_target.arn
# # }
# ################################################################################
# ## Application Loadbalancer Resources
# ################################################################################
# resource "aws_lb" "alb" {
#   name               = "alb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.load-balancer.id]
#   subnets            = [aws_subnet.public_1.id, aws_subnet.public_2.id]

# }
# resource "aws_lb_target_group" "asg_target" {
#   name     = "asg-target-group"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.vpc.id


# }
# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = 80
#   protocol          = "HTTP"
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.asg_target.arn
#   }
# }



# # resource "aws_lb_target_group_attachment" "asg" {
# #   target_group_arn = aws_lb_target_group.asg_target.arn
# #   target_id        = aws_autoscaling_group.asg.id
# #   port             = 80
# # }
# resource "aws_autoscaling_attachment" "asg_attachment" {
#   autoscaling_group_name = aws_autoscaling_group.asg.name
#   lb_target_group_arn    = aws_lb_target_group.asg_target.arn
# }










