# modules/load_balancer/outputs.tf

output "lb_arn" {
  description = "ARN of the load balancer"
  value       = aws_lb.main.arn
}

output "lb_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

