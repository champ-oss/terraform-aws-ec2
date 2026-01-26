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
