data "template_file" "consul_servers_userdata" {
  template = "${file("${path.module}/userdata.sh")}"

  vars {
    cluster_tag_key   = "${var.cluster_tag_key}"
    cluster_tag_value = "auto-join"
    ca_path           = "${var.ca_path}"
    cert_file_path    = "${var.cert_file_path}"
    key_file_path     = "${var.key_file_path}"
  }
}

module "consul_servers" {
  source  = "hashicorp/consul/aws//modules/consul-cluster"
  version = "0.5.0"

  cluster_name  = "${var.cluster_name}"
  cluster_size  = "${var.num_servers}"
  instance_type = "${var.instance_type}"

  ami_id    = "ami-09631ed50482fb39d"
  user_data = "${data.template_file.consul_servers_userdata.rendered}"

  vpc_id     = "${data.terraform_remote_state.aws_networking.vpc_id}"
  subnet_ids = "${data.terraform_remote_state.aws_networking.public_subnet_ids}"

  # To make testing easier, we allow Consul and SSH requests from any IP address here but in a production
  # deployment, we strongly recommend you limit this to the IP address ranges of known, trusted servers inside your VPC.
  allowed_ssh_cidr_blocks = ["0.0.0.0/0"]

  allowed_inbound_cidr_blocks = ["0.0.0.0/0"]
  ssh_key_name                = "pbartine"

  enable_iam_setup = false
  iam_instance_profile_name = "consul-role"

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
  ]
}
