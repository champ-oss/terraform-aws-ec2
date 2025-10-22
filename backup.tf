resource "aws_backup_vault" "this" {
  count = var.enabled ? 1 : 0
  name  = var.git
  tags  = merge(local.tags, var.tags)
}

resource "aws_backup_plan" "this" {
  count = var.enabled ? 1 : 0
  name  = var.git

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.this[0].name
    schedule          = var.backup_cron_expression
    lifecycle {
      delete_after = var.backup_retention_days
    }
  }
  tags = merge(local.tags, var.tags)
}

resource "aws_iam_role_policy_attachment" "backup_role_attachment" {
  count      = var.enabled ? 1 : 0
  role       = aws_iam_role.backup_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_backup_selection" "this" {
  count        = var.enabled ? 1 : 0
  name         = var.git
  iam_role_arn = aws_iam_role.backup_role[0].arn
  plan_id      = aws_backup_plan.this[0].id

  resources = [
    "arn:aws:ec2:${data.aws_region.this[0].name}:${data.aws_caller_identity.this[0].account_id}:instance/${try(aws_instance.this[0].id, "")}"
  ]
}