variable "name" {
  description = "Name of the Aurora DB Cluster"
  type        = string
}

variable "engine_version" {
  description = "Engine version for the Aurora DB Cluster"
  type        = string
}

variable "master_username" {
  description = "Master username for Aurora DB Cluster"
  type        = string
}

variable "master_password" {
  description = "Master password for Aurora DB Cluster"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name for the Aurora DB Cluster"
  type        = string
}

variable "db_subnet_group" {
  description = "DB subnet group for Aurora"
  type        = string
}

variable "writer_instance_type" {
  description = "Instance type for the Aurora writer instance"
  type        = string
}

variable "reader_instance_type" {
  description = "Instance type for the Aurora reader instance"
  type        = string
}

variable "reader_enabled" {
  description = "Flag to enable reader instance for Aurora DB Cluster"
  type        = bool
  default     = true
}
