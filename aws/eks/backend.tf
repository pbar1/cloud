terraform {
  backend "gcs" {
    bucket = "tf-state-390820"
    prefix = "cloud/aws/eks"
  }
}

provider "aws" {
  version = "~> 2.0"
  region  = "us-west-2"
}
