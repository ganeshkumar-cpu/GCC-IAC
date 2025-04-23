resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = var.name
  engine                  = "aurora-mysql"
  engine_version          = var.engine_version
  master_username         = var.master_username
  master_password         = var.master_password
  database_name           = "maindb"
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
}

resource "aws_rds_cluster_instance" "writer" {
  identifier              = "${var.name}-instance-1"
  cluster_identifier      = aws_rds_cluster.aurora.id
  instance_class          = var.instance_class
  engine                  = aws_rds_cluster.aurora.engine
  engine_version          = var.engine_version
  availability_zone       = var.writer_az
}

resource "aws_rds_cluster_instance" "reader" {
  count                   = var.reader_az != null ? 1 : 0
  identifier              = "${var.name}-instance-1-${var.reader_az}"
  cluster_identifier      = aws_rds_cluster.aurora.id
  instance_class          = var.instance_class
  engine                  = aws_rds_cluster.aurora.engine
  engine_version          = var.engine_version
  availability_zone       = var.reader_az
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "db_sg" {
  name        = "${var.name}-db-sg"
  description = "Aurora DB SG"
  vpc_id      = var.vpc_id
}
