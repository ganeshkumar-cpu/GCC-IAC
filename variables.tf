# variables.tf
variable "prod_db_password" {
  description = "Password for the production Aurora database"
  type        = string
  sensitive   = true
}

variable "dev_db_password" {
  description = "Password for the development Aurora database"
  type        = string
  sensitive   = true
}

