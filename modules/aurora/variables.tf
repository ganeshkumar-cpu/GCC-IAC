variable "name" {}
variable "engine_version" {}
variable "master_username" {}
variable "master_password" {}
variable "instance_class" {}
variable "writer_az" {}
variable "reader_az" {
  default = null
}
variable "subnet_ids" {
  type = list(string)
}
variable "vpc_id" {}
