output "vpc_id" {
  value = module.grse_vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.grse_vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.grse_vpc.private_subnet_ids
}

