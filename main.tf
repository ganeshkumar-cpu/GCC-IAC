provider "aws" {
  region = "ap-south-1"
}

module "prod_instance" {
  source               = "./modules/ec2_asg"
  name                 = "prod-server"
  environment          = "production"
  subnet_ids           = var.public_subnet_ids
  vpc_id               = var.vpc_id
  instance_type        = "m6a.xlarge"
  desired_capacity     = 1
}

module "dev_instance" {
  source               = "./modules/ec2_asg"
  name                 = "dev-server"
  environment          = "development"
  subnet_ids           = var.public_subnet_ids
  vpc_id               = var.vpc_id
  instance_type        = "t3.micro"
  desired_capacity     = 1
}

module "prod_db" {
  source               = "./modules/aurora"
  name                 = "facedetectiontest"
  engine_version       = "8.0.mysql_aurora.3.04.0"
  master_username      = "admin"
  master_password      = var.prod_db_password
  instance_class       = "db.r5.large"
  writer_az            = "ap-south-1b"
  reader_az            = null
  subnet_ids           = var.db_subnet_ids
  vpc_id               = var.vpc_id
}

module "dev_db" {
  source               = "./modules/aurora"
  name                 = "gcc-facial-db"
  engine_version       = "8.0.mysql_aurora.3.04.0"
  master_username      = "admin"
  master_password      = var.dev_db_password
  instance_class       = "db.r6g.xlarge"
  writer_az            = "ap-south-1a"
  reader_az            = "ap-south-1b"
  subnet_ids           = var.db_subnet_ids
  vpc_id               = var.vpc_id
}
module "prod_sg" {
  source = "./modules/security_group"
  name   = "prod-server-sg"
  vpc_id = var.vpc_id

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["YOUR.IP.ADDRESS/32"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "dev_sg" {
  source = "./modules/security_group"
  name   = "dev-server-sg"
  vpc_id = var.vpc_id

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["YOUR.IP.ADDRESS/32"]
    }
  ]
}

