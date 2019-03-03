resource "aws_iam_instance_profile" "packer" {
  name = "packer-instance-profile"
  role = "${aws_iam_role.packer.name}"
}

resource "aws_iam_role" "packer" {
  name               = "packer-role"
  assume_role_policy = "${data.aws_iam_policy_document.assume_ec2.json}"
}

data "aws_iam_policy_document" "assume_ec2" {
  statement {
    sid     = "AssumeEC2"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "packer" {
  role       = "${aws_iam_role.packer.name}"
  policy_arn = "${aws_iam_policy.packer.arn}"
}

resource "aws_iam_policy" "packer" {
  name        = "packer-policy"
  description = "Minimal set permissions necessary for Packer to work"
  policy      = "${data.aws_iam_policy_document.packer.json}"
}

data "aws_iam_policy_document" "packer" {
  statement {
    sid    = "Packer"
    effect = "Allow"

    actions = [
      "ec2:AttachVolume",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CopyImage",
      "ec2:CreateImage",
      "ec2:CreateKeypair",
      "ec2:CreateSecurityGroup",
      "ec2:CreateSnapshot",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:DeleteKeyPair",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteSnapshot",
      "ec2:DeleteVolume",
      "ec2:DeregisterImage",
      "ec2:DescribeImageAttribute",
      "ec2:DescribeImages",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeRegions",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSnapshots",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DetachVolume",
      "ec2:GetPasswordData",
      "ec2:ModifyImageAttribute",
      "ec2:ModifyInstanceAttribute",
      "ec2:ModifySnapshotAttribute",
      "ec2:RegisterImage",
      "ec2:RunInstances",
      "ec2:StopInstances",
      "ec2:TerminateInstances",
    ]

    resources = ["*"]
  }
}
