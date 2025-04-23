variable "vpc_id" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "db_subnet_ids" {
  type = list(string)
}
variable "prod_db_password" {
  sensitive = true
}
variable "dev_db_password" {
  sensitive = true
}
