terraform {
  backend "gcs" {
    bucket = "tf-state-390820"
    prefix = "cloud/aws"       # should mirror the repo structure
  }
}

provider "aws" {
  version = "~> 2.0"    # pins the major.minor version, a good practice
  region  = "us-west-2"
}
