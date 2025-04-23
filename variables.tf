variable "dev_ami" {
  description = "AMI ID for the dev server"
  type        = string
}

variable "prod_ami" {
  description = "AMI ID for the prod server"
  type        = string
}

variable "key_name" {
  description = "SSH Key name"
  type        = string
}

variable "dev_db_password" {
  description = "Database password for dev environment"
  type        = string
  sensitive   = true
}

variable "prod_db_password" {
  description = "Database password for prod environment"
  type        = string
  sensitive   = true
}
