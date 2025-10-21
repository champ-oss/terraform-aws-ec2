resource "aws_iam_role_policy_attachment" "this" {
  count      = var.enabled ? 1 : 0
  role       = aws_iam_role.this[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "this" {
  count              = var.enabled ? 1 : 0
  name_prefix        = var.git
  assume_role_policy = data.aws_iam_policy_document.this[0].json
  tags               = merge(local.tags, var.tags)
}

resource "aws_iam_role" "backup_role" {
  count       = var.enabled ? 1 : 0
  name_prefix = "${var.git}-backup-"
  tags        = merge(local.tags, var.tags)

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "backup.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}