provider "aws" {
  region = "ap-south-1"
}

# ───────────────────────────────────────────────
# VPC MODULE
module "vpc" {
  source = "./modules/vpc"

  cidr_block           = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
  azs                  = ["ap-south-1a", "ap-south-1b"]
}


# ───────────────────────────────────────────────
# SECURITY GROUPS
module "prod_sg" {
  source = "./modules/security_group"
  name   = "prod-server-sg"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
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
  vpc_id = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

# ───────────────────────────────────────────────
# EC2 INSTANCES (with Auto Scaling Group)
# Production EC2 Auto Scaling Group
module "prod_instance" {
  source               = "./modules/ec2_asg"
  ami                  = "ami-0c55b159cbfafe1f0"
  instance_name        = "prod-server"
  instance_type        = "m6a.xlarge"
  key_name             = "prod-key"
  root_volume_size     = 30
  ebs_volume_size      = 100
  subnet_ids           = module.vpc.public_subnet_ids
  vpc_id               = module.vpc.vpc_id
  desired_capacity     = 2
  min_size             = 2
  max_size             = 3
  security_group_ids   = [module.prod_sg.security_group_id]
}

# Development EC2 Auto Scaling Group
module "dev_instance" {
  source               = "./modules/ec2_asg"
  ami                  = "ami-0c55b159cbfafe1f0"
  instance_name        = "dev-server"
  instance_type        = "t3.micro"
  key_name             = "dev-key"
  root_volume_size     = 30
  ebs_volume_size      = 100
  subnet_ids           = module.vpc.public_subnet_ids
  vpc_id               = module.vpc.vpc_id
  desired_capacity     = 1
  min_size             = 1
  max_size             = 1
  security_group_ids   = [module.dev_sg.security_group_id]
}


# ───────────────────────────────────────────────
# DATABASE MODULES
module "prod_db" {
  source               = "./modules/aurora"
  name                 = "facedetectiontest"
  engine_version       = "8.0.mysql_aurora.3.04.0"
  master_username      = "admin"
  master_password      = var.prod_db_password
  instance_class       = "db.r5.large"
  writer_az            = "ap-south-1b"
  reader_az            = null
  subnet_ids           = module.vpc.private_subnet_ids
  vpc_id               = module.vpc.vpc_id
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
  subnet_ids           = module.vpc.private_subnet_ids
  vpc_id               = module.vpc.vpc_id
}
# ───────────────────────────────────────────────
# LOAD BALANCERS
module "prod_lb" {
  source = "./modules/load_balancer"

  lb_name      = "prod-lb"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.public_subnet_ids
  security_groups = [module.prod_sg.security_group_id]
}

module "dev_lb" {
  source = "./modules/load_balancer"

  lb_name      = "dev-lb"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.public_subnet_ids
  security_groups = [module.dev_sg.security_group_id]
}
