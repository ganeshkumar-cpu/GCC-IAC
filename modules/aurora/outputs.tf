output "db_cluster_endpoint" {
  value = aws_rds_cluster.this.endpoint
}

output "db_writer_endpoint" {
  value = aws_rds_cluster_instance.writer.endpoint
}

output "db_reader_endpoint" {
  value = aws_rds_cluster_instance.reader[0].endpoint
}
