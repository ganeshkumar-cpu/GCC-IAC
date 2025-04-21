variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets with AZ as keys"
  type        = map(string)
}

variable "private_subnets" {
  description = "Private subnets with AZ as keys"
  type        = map(string)
}

