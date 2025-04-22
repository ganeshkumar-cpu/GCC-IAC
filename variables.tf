# --------------------------
# VPC variables
# --------------------------

variable "vpc_name" {
  type        = string
  description = "The name of the VPC to be created."
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "public_subnets" {
  type        = map(string)
  description = "A map of public subnet CIDR blocks with AZ names as keys."
  # Example: { "ap-south-1a" = "10.0.1.0/24", "ap-south-1b" = "10.0.2.0/24" }
}

variable "private_subnets" {
  type        = map(string)
  description = "A map of private subnet CIDR blocks with AZ names as keys."
  # Example: { "ap-south-1a" = "10.0.11.0/24", "ap-south-1b" = "10.0.12.0/24" }
}

# --------------------------
# EC2 variables
# --------------------------

variable "ami" {
  type        = string
  description = "The AMI ID to use for launching the EC2 instance."
}

variable "instance_name" {
  type        = string
  description = "The name to assign to the EC2 instance."
}

variable "instance_type" {
  type        = string
  description = "The type of EC2 instance (e.g., t2.micro, t4g.2xlarge)."
}

variable "key_name" {
  type        = string
  description = "The name of the existing key pair to use for SSH access to the instance."
}

variable "root_volume_size" {
  type        = number
  description = "The size (in GiB) of the root EBS volume attached to the EC2 instance."
}

variable "ebs_volume_size" {
  type        = number
  description = "The size (in GiB) of an additional EBS volume to attach to the EC2 instance."
}

# --------------------------
# Security Group variables
# --------------------------

variable "security_group_name" {
  type        = string
  description = "The name to assign to the security group."
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "A list of ingress rules defining allowed inbound traffic for the security group."
  # Example:
  # [
  #   {
  #     from_port   = 22
  #     to_port     = 22
  #     protocol    = "tcp"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   },
  #   ...
  # ]
}
