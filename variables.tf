# VPC variables
variable "vpc_name" { type = string }
variable "vpc_cidr" { type = string }
variable "public_subnets" { type = map(string) }
variable "private_subnets" { type = map(string) }

# EC2 variables
variable "ami" { type = string }
variable "instance_name" { type = string }
variable "instance_type" { type = string }
variable "key_name" { type = string }
variable "root_volume_size" { type = number }
variable "ebs_volume_size" { type = number }

# Security Group variables
variable "security_group_name" { type = string }
variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
