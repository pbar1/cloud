terraform {
  backend "gcs" {
    bucket = "tf-state-390820"
    prefix = "cloud/aws/vault"
  }
}

provider "aws" {
  version = "~> 2.0"
  region  = "${var.aws_region}"
}
