variable "git" {
  description = "Name of the Git repo"
  type        = string
  default     = "terraform-aws-ec2"
}

variable "enabled" {
  description = "Enable or disable the creation of the resources"
  type        = bool
  default     = true
}

variable "backup_cron_expression" {
  description = "The cron expression for scheduling backups."
  type        = string
  default     = "cron(0 5 ? * * *)" # Daily at 5 AM UTC
}

variable "backup_retention_days" {
  description = "Number of days to retain backups"
  type        = number
  default     = 30
}

variable "ami_id" {
  description = "AMI ID to use (set this to roll back to a prior AMI)"
  type        = string
  default     = null # leave empty to use latest Amazon Linux 2 below
}

variable "instance_type" {
  description = "EC2 instance type for the bastion host"
  type        = string
  default     = "t3.nano"
}

variable "private_subnet_ids" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster#subnet_ids"
  type        = string
  default     = null
}

variable "volume_size" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#volume_size-1"
  type        = number
  default     = 8
}

variable "protect_root_volume" {
  description = "Whether to protect the root volume from accidental deletion"
  type        = bool
  default     = true
}

variable "ec2_user_data_script" {
  description = "Name of the user data script to use"
  type        = string
  default     = "ec2_user_data.sh"
}

variable "vpc_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#vpc_id"
  type        = string
}

variable "tags" {
  description = "Map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "amazon_ami_version" {
  description = "The Amazon Linux 2 AMI version to use"
  type        = string
  default     = "amzn2-ami-hvm-2.0.20251014.0-x86_64-gp2"
}

variable "create_ssm_endpoint" {
  description = "Whether to create VPC endpoints for SSM"
  type        = bool
  default     = true
}

variable "ssm_manager_security_group_id" {
  description = "Optional security group ID to use for ssm manager"
  type        = string
  default     = null
}
