variable "environment" {}

variable "aws_region" {}

variable "tags" {
  type = "map"

  default = {
    ManagedBy = "Terraform"
  }
}

variable "remote_state_workspace_dns" {}

variable "domain_name" {}

variable "registration_email" {}
