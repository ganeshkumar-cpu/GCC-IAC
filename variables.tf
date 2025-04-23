variable "dev_ami" {
  description = "AMI for development EC2 instances"
  type        = string
}

variable "prod_ami" {
  description = "AMI for production EC2 instances"
  type        = string
}

variable "key_name" {
  description = "SSH key name for EC2 instances"
  type        = string
}

variable "dev_db_password" {
  description = "Password for the dev database"
  type        = string
  sensitive   = true
}
