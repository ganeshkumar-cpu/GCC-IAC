# modules/aurora/outputs.tf

output "db_cluster_endpoint" {
  description = "Endpoint of the Aurora DB cluster"
  value       = aws_rds_cluster.aurora.endpoint
}

output "db_reader_endpoint" {
  description = "Reader endpoint of the Aurora DB cluster"
  value       = aws_rds_cluster.aurora.reader_endpoint
}

output "db_sg_id" {
  description = "Security group ID of the Aurora DB instance"
  value       = aws_security_group.db_sg.id
}
