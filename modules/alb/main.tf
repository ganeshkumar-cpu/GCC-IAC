resource "aws_lb" "this" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups   = var.security_group_ids
  subnets           = var.subnet_ids
  enable_deletion_protection = false

  enable_cross_zone_load_balancing = true
}

resource "aws_lb_target_group" "this" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

output "dns_name" {
  value = aws_lb.this.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}

