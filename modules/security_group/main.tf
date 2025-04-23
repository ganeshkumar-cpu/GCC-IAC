resource "aws_security_group" "this" {
  name        = var.name
  description = "Allow inbound traffic for ${var.name}"
}

output "id" {
  value = aws_security_group.this.id
}
