variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Key pair name for EC2 instances"
  type        = string
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
}

variable "ebs_volume_size" {
  description = "Size of the additional EBS volume in GB"
  type        = number
}

variable "subnet_ids" {
  description = "List of subnet IDs to launch the EC2 instance in"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where the EC2 instance will be launched"
  type        = string
}

variable "desired_capacity" {
  description = "Desired capacity for the EC2 Auto Scaling Group"
  type        = number
}

variable "security_group_ids" {
  description = "Security group IDs associated with the EC2 instance"
  type        = list(string)
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}
variable "min_size" {
  description = "Minimum number of EC2 instances in the ASG"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of EC2 instances in the ASG"
  type        = number
  default     = 1
}
