module "grse_vpc" {
  source   = "./modules/vpc"
  vpc_name = "GRSE-vpc"
  vpc_cidr = "10.40.0.0/16"

  public_subnets = {
    "ap-south-1a" = "10.40.101.0/24"
    "ap-south-1b" = "10.40.102.0/24"
  }

  private_subnets = {
    "ap-south-1a" = "10.40.11.0/24"
    "ap-south-1b" = "10.40.12.0/24"
  }
}
module "grse_security_group" {
  source = "./modules/security_group"
  name   = "GRSE-APP&DB-SG"
}

module "grse_ec2" {
  source           = "./modules/ec2"
  instance_name    = "GRSE-APP&DB"
  instance_type    = "t4g.2xlarge"
  key_name         = "GRSE-key"
  root_volume_size = 400
  ebs_volume_size  = 500
  security_group_ids = [module.grse_security_group.security_group_id]
}
