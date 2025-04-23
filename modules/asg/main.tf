resource "aws_launch_configuration" "this" {
  name                  = var.name
  image_id              = var.ami_id
  instance_type         = var.instance_type
  security_groups      = var.security_group_ids
  user_data             = var.user_data
  key_name              = var.key_name
  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp2"
  }
}

resource "aws_autoscaling_group" "this" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = var.subnet_ids
  launch_configuration = aws_launch_configuration.this.id
  target_group_arns    = var.target_group_arns
  health_check_type    = "EC2"
  health_check_grace_period = 300
  force_delete         = true

  tags = [
    {
      key                 = "Name"
      value               = var.name
      propagate_at_launch = true
    }
  ]
}

output "asg_name" {
  value = aws_autoscaling_group.this.name
}

output "asg_id" {
  value = aws_autoscaling_group.this.id
}
