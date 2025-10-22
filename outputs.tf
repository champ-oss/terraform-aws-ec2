output "role_arn" {
  description = "The ARN of the IAM role associated with the bastion host."
  value       = var.enabled ? aws_iam_role.this[0].arn : ""
}