variable "ami" { type = string }
variable "instance_name" { type = string }
variable "instance_type" { type = string }
variable "key_name" { type = string }
variable "security_group_ids" { type = list(string) }
variable "root_volume_size" { type = number }
variable "ebs_volume_size" { type = number }

