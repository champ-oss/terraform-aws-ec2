data "aws_ami" "this" {
  count       = var.enabled ? 1 : 0
  most_recent = false
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["${var.amazon_ami_version}"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_iam_policy_document" "this" {
  count = var.enabled ? 1 : 0
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_region" "this" {
  count = var.enabled ? 1 : 0
}
data "aws_caller_identity" "this" {
  count = var.enabled ? 1 : 0
}
