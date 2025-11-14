output "role_name" {
  description = "The ARN of the IAM role associated with the bastion host."
  value       = var.enabled ? aws_iam_role.this[0].name : ""
}

output "ec2_security_group_id" {
  description = "The ID of the security group associated with the bastion host."
  value       = var.enabled ? aws_security_group.ec2[0].id : ""
}

output "ssm_manager_security_group_id" {
  description = "The ID of the security group used for SSM manager."
  value       = var.enabled && var.create_ssm_endpoint ? aws_security_group.ssm_manager[0].id : ""
}

output "instance_id" {
  description = "The ID of the bastion host EC2 instance."
  value       = var.enabled ? aws_instance.this[0].id : ""
}