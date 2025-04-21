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

