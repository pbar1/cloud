variable "environment" {}

variable "aws_region" {}

variable "tags" {
  type    = "map"
  default = {}
}

variable "cidr" {}

variable "azs" {
  type = "list"
}

variable "private_subnets" {
  type = "list"
}

variable "public_subnets" {
  type = "list"
}

variable "enable_nat_gateway" {
  default = true
}

variable "enable_vpn_gateway" {
  default = false
}
