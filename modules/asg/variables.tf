variable "name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the Auto Scaling EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for Auto Scaling"
  type        = string
}

variable "security_group_ids" {
  description = "Security group IDs for the EC2 instances"
  type        = list(string)
}

variable "user_data" {
  description = "User data for initializing EC2 instances"
  type        = string
}

variable "key_name" {
  description = "SSH key name for EC2 instances"
  type        = string
}

variable "desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
}

variable "min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling Group"
  type        = list(string)
}

variable "target_group_arns" {
  description = "List of target group ARNs for the ALB"
  type        = list(string)
}

variable "root_volume_size" {
  description = "Root volume size for EC2 instances"
  type        = number
  default     = 20
}
