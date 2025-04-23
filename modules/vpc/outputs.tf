output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets" {
  value = [aws_subnet.public_ap_south_1a.id, aws_subnet.public_ap_south_1b.id]
}

output "private_subnets" {
  value = [aws_subnet.private_ap_south_1a.id, aws_subnet.private_ap_south_1b.id]
}
