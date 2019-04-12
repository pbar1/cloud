variable "environment" {}

variable "aws_region" {
  default = "us-west-2"
}

variable "tags" {
  type = "map"

  default = {
    ManagedBy = "Terraform"
  }
}

variable "domain_name" {}
