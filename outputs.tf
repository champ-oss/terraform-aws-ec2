output "role_name" {
  description = "The ARN of the IAM role associated with the bastion host."
  value       = var.enabled ? aws_iam_role.this[0].name : ""
}
