terraform {
  backend "gcs" {
    bucket = "tf-state-390820"
    prefix = "cloud/aws/iam" # should mirror repo structure for clarity
  }
}

provider "aws" {
  version = "~> 2.0"    # pins minor version to avoid breaking changes
  region  = "us-west-2"
}
