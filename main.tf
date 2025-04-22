module "grse_vpc" {
  source           = "./modules/vpc"
  vpc_name         = var.vpc_name
  vpc_cidr         = var.vpc_cidr
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
}

module "grse_security_group" {
  source         = "./modules/security_group"
  name           = var.security_group_name
  vpc_id         = module.grse_vpc.vpc_id
  ingress_rules  = var.ingress_rules
}

module "grse_ec2" {
  source             = "./modules/ec2"
  ami                = var.ami
  instance_name      = var.instance_name
  instance_type      = var.instance_type
  key_name           = var.key_name
  root_volume_size   = var.root_volume_size
  ebs_volume_size    = var.ebs_volume_size
  security_group_ids = [module.grse_security_group.security_group_id]
}
