variable "name" {}
variable "environment" {}
variable "subnet_ids" {
  type = list(string)
}
variable "vpc_id" {}
variable "instance_type" {}
variable "desired_capacity" {
  default = 1
}
