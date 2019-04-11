locals {
  name = "${var.environment}"

  tags = "${merge(
    var.tags,
    map("Name", local.name),
    map("Environment", var.environment),
    map("ManagedBy", "Terraform")
  )}"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.58.0"

  name = "${local.name}"
  tags = "${local.tags}"

  cidr            = "${var.cidr}"
  azs             = "${var.azs}"
  private_subnets = "${var.private_subnets}"
  public_subnets  = "${var.public_subnets}"

  enable_nat_gateway = "${var.enable_nat_gateway}"
  enable_vpn_gateway = "${var.enable_vpn_gateway}"
}
