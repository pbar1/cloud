locals {
  tags = "${merge(
    var.tags,
    map("Environment", var.environment),
  )}"
}

data "terraform_remote_state" "dns" {
  backend   = "gcs"
  workspace = "${var.remote_state_workspace_dns}"

  config = {
    bucket = "tf-state-390820"
    prefix = "cloud/aws/dns"
  }
}

module "vault_cert" {
  source  = "pbar1/acme-ssm/aws"
  version = "1.0.0"

  tags                   = "${local.tags}"
  common_name            = "${var.domain_name}"
  registration_email     = "${var.registration_email}"
  route53_hosted_zone_id = "${data.terraform_remote_state.dns.zone_id}"

  ssm_path_cert         = "/vault/tls.pem"
  ssm_path_intermediate = "/vault/tls-intermediate.pem"
  ssm_path_key          = "/vault/tls-key.pem"
}
