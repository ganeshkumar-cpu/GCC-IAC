module "vpc" {
  source                  = "./modules/vpc"
  vpc_cidr                = var.vpc_cidr
  vpc_name                = var.vpc_name
  public_subnet_cidr      = var.public_subnet_cidr
  public_subnet_az        = var.public_subnet_az
  private_subnet_cidr     = var.private_subnet_cidr
  private_subnet_az       = var.private_subnet_az
  public_db_subnet_cidr   = var.public_db_subnet_cidr
  public_db_subnet_az     = var.public_db_subnet_az
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "ec2_instances" {
  source                = "./modules/ec2"
  vpc_id                = module.vpc.vpc_id
  api_server_1_sg_id    = module.security_group.api_server_1_sg_id
  api_server_2_sg_id    = module.security_group.api_server_2_sg_id
  web_db_server_sg_id   = module.security_group.web_db_server_sg_id

  api_server_1_ami      = var.api_server_1_ami
  api_server_2_ami      = var.api_server_2_ami
  web_db_server_ami     = var.web_db_server_ami

  api_servers_key_name  = var.api_servers_key_name
  web_db_key_name       = var.web_db_key_name
}
