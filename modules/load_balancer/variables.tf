variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the load balancer will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to associate with the load balancer"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs to associate with the load balancer"
  type        = list(string)
}
