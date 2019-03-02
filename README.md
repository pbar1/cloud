# cloud

This is basically my scratchpad repo for cloud infrastructure. It uses Terraform backed by Google Cloud Storage (GCS) because it has an excellent always-free tier, and you should always store your state remotely!

## Requirements

### Terraform

As stated, I'm using Hashicorp Terraform to build the infrastructure in this repo. I'm using this standard for Terraform remote state, always in `backend.tf`:

```
terraform {
  backend "gcs" {
    bucket = "tf-state-390820"
    prefix = "cloud/aws"       # this should mirror the repo structure
  }
}
```

For this to work, set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable to a path pointing at a JSON file containing your GCP credentials. For example,

```
export GOOGLE_APPLICATION_CREDENTIALS="/home/user/Downloads/[FILE_NAME].json"
```

## Structure

```
.
├── aws
├── azure
├── gcp
└── k8s
```
