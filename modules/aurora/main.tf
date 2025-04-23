resource "aws_rds_cluster" "this" {
  cluster_identifier      = var.name
  engine                 = "aurora-mysql"
  engine_version         = var.engine_version
  master_username        = var.master_username
  master_password        = var.master_password
  database_name          = var.db_name
  db_subnet_group_name   = var.db_subnet_group
  skip_final_snapshot    = true
  storage_encrypted      = true
  backup_retention_period = 7

  tags = {
    Name = var.name
  }
}

resource "aws_rds_cluster_instance" "writer" {
  cluster_identifier      = aws_rds_cluster.this.id
  instance_class          = var.writer_instance_type
  engine                  = aws_rds_cluster.this.engine
  publicly_accessible     = false
  db_subnet_group_name    = var.db_subnet_group

  tags = {
    Name = "${var.name}-writer"
  }
}

resource "aws_rds_cluster_instance" "reader" {
  count                  = var.reader_enabled ? 1 : 0
  cluster_identifier     = aws_rds_cluster.this.id
  instance_class         = var.reader_instance_type
  engine                 = aws_rds_cluster.this.engine
  publicly_accessible    = false
  db_subnet_group_name   = var.db_subnet_group

  tags = {
    Name = "${var.name}-reader"
  }
}

output "db_cluster_endpoint" {
  value = aws_rds_cluster.this.endpoint
}

output "db_writer_endpoint" {
  value = aws_rds_cluster_instance.writer.endpoint
}

output "db_reader_endpoint" {
  value = aws_rds_cluster_instance.reader[0].endpoint
}
