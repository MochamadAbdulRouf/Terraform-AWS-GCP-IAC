# Data Source mengambil AMI Amazon Linux 2 Terbaru 
data "aws_ami" "amazone_linux_2" {
    most_recent = true
    owners      = ["amazon"]
  
    filter {
      name   = "name"
      values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}

# Security Group
resource "aws_security_group" "lb_sg" {
    name        = "${var.project_name}-lb-sg"
    description = "Allow HTTP inbound traffic"
    vpc_id      = var.vpc_id

    ingress  {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "ec2_sg" {
    name        = "${var.project_name}-ec2-sg"
    description = "Allow traffic from ALB only"
    vpc_id      = var.vpc_id

    ingress  {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        security_groups = [aws_security_group.lb_sg.id] # Security chaining 
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_lb" "app_lb" {
    name               = "${var.project_name}-alb"
    internal           = false 
    load_balancer_type = "application"
    security_groups    = [aws_security_group.lb_sg.id]
    subnets            = var.public_subnet_ids
}

resource "aws_lb_target_group" "app_tg" {
    name     = "${var.project_name}-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "front_end" {
    load_balancer_arn = aws_lb.app_lb.arn 
    port              = 80 
    protocol          = "HTTP"


    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.app_tg.arn 
    }   
}

resource "aws_launch_template" "app_lt" {
    name_prefix   = "${var.project_name}-lt-"
    image_id      = data.aws_ami.amazone_linux_2.id 
    instance_type = "t2.micro"

    network_interfaces {
      associate_public_ip_address = true 
      security_groups             = [aws_security_group.ec2_sg.id] 
    }
  
    user_data = base64encode(<<-EOF
                  #!/bin/bash
                  yum install -y httpd
                  systemctl start httpd
                  systemctl enable httpd
                  echo "<h1>Hello from Terraform!</h1><p>Server ID: $(hostname)</p>" > /var/www/html/index.html
                  systemctl restart httpd
                  EOF
    )

    tag_specifications {
      resource_type = "instance"

      tags = {
        Name = "${var.project_name}-server"
        Project = var.project_name 
      }
    }
}

resource "aws_autoscaling_group" "app_asg" {
    name                = "${var.project_name}-asg"
    desired_capacity    = 2
    max_size            = 3 
    min_size            = 1
    vpc_zone_identifier = var.public_subnet_ids
    target_group_arns   = [aws_lb_target_group.app_tg.arn]

    launch_template {
      id      = aws_launch_template.app_lt.id
      version = "$Latest"
    }

    # Fitur mematikan instance lama secara bertahap dan menggantinya dengan baru
    instance_refresh {
      strategy = "Rolling"
      preferences {
        min_healthy_percentage = 50
      }
    }
}
