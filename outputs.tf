output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}
# outputs.tf in root directory

output "prod_lb_arn" {
  description = "ARN of the production load balancer"
  value       = module.prod_lb.lb_arn
}

output "prod_lb_dns_name" {
  description = "DNS name of the production load balancer"
  value       = module.prod_lb.lb_dns_name
}

output "dev_lb_arn" {
  description = "ARN of the development load balancer"
  value       = module.dev_lb.lb_arn
}

output "dev_lb_dns_name" {
  description = "DNS name of the development load balancer"
  value       = module.dev_lb.lb_dns_name
}

# For production DB outputs
output "prod_db_cluster_endpoint" {
  description = "Endpoint of the production Aurora DB cluster"
  value       = module.prod_db.db_cluster_endpoint
}

output "prod_db_reader_endpoint" {
  description = "Reader endpoint of the production Aurora DB cluster"
  value       = module.prod_db.db_reader_endpoint
}

output "prod_db_sg_id" {
  description = "Security group ID of the production Aurora DB instance"
  value       = module.prod_db.db_sg_id
}

# For development DB outputs
output "dev_db_cluster_endpoint" {
  description = "Endpoint of the development Aurora DB cluster"
  value       = module.dev_db.db_cluster_endpoint
}

output "dev_db_reader_endpoint" {
  description = "Reader endpoint of the development Aurora DB cluster"
  value       = module.dev_db.db_reader_endpoint
}

output "dev_db_sg_id" {
  description = "Security group ID of the development Aurora DB instance"
  value       = module.dev_db.db_sg_id
}
output "prod_asg_name" {
  value = module.prod_instance.asg_name
}

output "prod_asg_id" {
  value = module.prod_instance.asg_id
}

output "prod_launch_template_id" {
  value = module.prod_instance.launch_template_id
}

output "prod_asg_instances" {
  value = module.prod_instance.asg_instances
}

output "dev_asg_name" {
  value = module.dev_instance.asg_name
}

output "dev_asg_id" {
  value = module.dev_instance.asg_id
}

output "dev_launch_template_id" {
  value = module.dev_instance.launch_template_id
}

output "dev_asg_instances" {
  value = module.dev_instance.asg_instances
}

