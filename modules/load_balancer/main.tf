
resource "aws_lb" "main" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnet_ids
  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true

  tags = {
    Name = var.lb_name
  }
}

resource "aws_lb_target_group" "main" {
  name     = "${var.lb_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = "80"
  }
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.main.arn
    type             = "forward"
  }
}

