provider "aws" {
  region = "ap-south-1"
}

module "grse_vpc" {
  source = "./modules/vpc"

  vpc_name = "GRSE-vpc"
  vpc_cidr = "10.0.0.0/16"

  public_subnets = {
    "ap-south-1a" = "10.0.1.0/24"
    "ap-south-1b" = "10.0.3.0/24"
  }

  private_subnets = {
    "ap-south-1a" = "10.0.2.0/24"
    "ap-south-1b" = "10.0.4.0/24"
  }
}


