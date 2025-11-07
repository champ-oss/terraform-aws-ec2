output "role_name" {
  description = "The ARN of the IAM role associated with the bastion host."
  value       = var.enabled ? aws_iam_role.this[0].name : ""
}

output "security_group_id" {
  description = "The ID of the security group associated with the bastion host."
  value       = var.enabled ? aws_security_group.ec2[0].id : ""
}

