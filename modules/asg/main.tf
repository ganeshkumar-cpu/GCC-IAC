resource "aws_launch_template" "lt" {
  name_prefix   = "${var.name}-lt"
  image_id      = "ami-0522ab6e1ddcc7055"  # Example AMI
  instance_type = var.instance_type
  key_name      = "GRSE-key"

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.sg.id]
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 50
      volume_type = "gp3"
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  name                      = "${var.name}-asg"
  max_size                  = 1
  min_size                  = 1
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = var.subnet_ids
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "sg" {
  name        = "${var.name}-sg"
  description = "${var.environment} security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
