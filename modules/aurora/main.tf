resource "aws_rds_cluster" "this" {
  cluster_identifier = var.name
  engine            = "aurora-mysql"
  master_username   = var.master_username
  master_password   = var.master_password
  database_name     = var.db_name
  engine_version    = var.engine_version
}

resource "aws_rds_cluster_instance" "this" {
  count              = var.reader_enabled ? 2 : 1
  cluster_identifier = aws_rds_cluster.this.id
  instance_class     = var.writer_instance_type
  engine             = "aurora-mysql"
}

output "db_cluster_endpoint" {
  value = aws_rds_cluster.this.endpoint
}

output "db_writer_endpoint" {
  value = aws_rds_cluster.this.reader_endpoint
}
