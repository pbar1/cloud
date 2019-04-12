locals {
  name = "${var.environment}"

  tags = "${merge(
    var.tags,
    map("Environment", var.environment),
  )}"
}

resource "aws_route53_zone" "main" {
  tags = "${local.tags}"
  name = "${var.domain_name}"
}
