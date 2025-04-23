provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source      = "./modules/vpc"
  cidr_block  = "10.0.0.0/16"
  vpc_name    = "GRSE-VPC"
}

module "dev_sg" {
  source = "./modules/security_group"
  name   = "dev-sg"
}

module "prod_sg" {
  source = "./modules/security_group"
  name   = "prod-sg"
}

module "db_sg" {
  source = "./modules/security_group"
  name   = "db-sg"
}

module "dev_alb" {
  source             = "./modules/alb"
  name               = "dev-alb"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnets
  security_group_ids = [module.dev_sg.id]
  target_group_name  = "dev-tg"
}

module "prod_alb" {
  source             = "./modules/alb"
  name               = "prod-alb"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnets
  security_group_ids = [module.prod_sg.id]
  target_group_name  = "prod-tg"
}

module "dev_asg" {
  source             = "./modules/asg"
  name               = "dev-asg"
  ami_id             = var.dev_ami
  instance_type      = "t3.micro"
  key_name           = var.key_name
  user_data          = file("user_data.sh")
  desired_capacity   = 1
  max_size           = 3
  min_size           = 1
  subnet_ids         = module.vpc.public_subnets
  security_group_ids = [module.dev_sg.id]
  target_group_arns  = [module.dev_alb.target_group_arn]
}

module "prod_asg" {
  source             = "./modules/asg"
  name               = "prod-asg"
  ami_id             = var.prod_ami
  instance_type      = "m5.large"
  key_name           = var.key_name
  user_data          = file("user_data.sh")
  desired_capacity   = 2
  max_size           = 5
  min_size           = 2
  subnet_ids         = module.vpc.public_subnets
  security_group_ids = [module.prod_sg.id]
  target_group_arns  = [module.prod_alb.target_group_arn]
}

module "dev_db" {
  source               = "./modules/aurora"
  name                 = "dev-db"
  engine_version       = "8.0.mysql_aurora.3.04.0"
  db_name              = "devdb"
  master_username      = "admin"
  master_password      = var.dev_db_password
  writer_instance_type = "db.r5.large"
  reader_enabled       = true
  reader_instance_type = "db.r5.large"
  writer_az            = "ap-south-1a"
  reader_az            = "ap-south-1b"
  db_subnet_group      = module.vpc.db_sub

module "prod_db" {
  source               = "./modules/aurora"
  name                 = "prod-db"
  engine_version       = "8.0.mysql_aurora.3.04.0"
  db_name              = "proddb"
  master_username      = "admin"
  master_password      = var.prod_db_password
  writer_instance_type = "db.r5.large"
  reader_enabled       = true
  reader_instance_type = "db.r5.large"
  writer_az            = "ap-south-1a"
  reader_az            = "ap-south-1b"
  db_subnet_group      = module.vpc.db_subnet_group
}
