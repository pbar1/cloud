output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}

output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = "${module.vpc.nat_public_ips}"
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = "${module.vpc.private_subnets}"
}

output "private_subnets_cidr_blocks" {
  description = "List of private subnet CIDR blocks"
  value       = "${module.vpc.private_subnets_cidr_blocks}"
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = "${module.vpc.public_subnets}"
}

output "public_subnets_cidr_blocks" {
  description = "List of public subnet CIDR blocks"
  value       = "${module.vpc.public_subnets_cidr_blocks}"
}
