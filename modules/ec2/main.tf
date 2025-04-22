resource "aws_instance" "this" {
  ami                         = "ami-xxxxxxxx" # Replace with latest ARM-compatible Ubuntu AMI
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
  }

  tags = {
    Name = var.instance_name
  }
}

resource "aws_ebs_volume" "this" {
  availability_zone = aws_instance.this.availability_zone
  size              = var.ebs_volume_size
  type              = "gp3"

  tags = {
    Name = "${var.instance_name}-ebs"
  }
}

resource "aws_volume_attachment" "this" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.this.id
  instance_id = aws_instance.this.id
}

