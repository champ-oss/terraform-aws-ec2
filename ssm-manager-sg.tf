resource "aws_security_group" "ssm_manager" {
  count       = var.enabled ? 1 : 0
  name_prefix = var.git
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.tags, var.tags)
}

resource "aws_security_group_rule" "ssm_manager_inbound" {
  count                    = var.enabled ? 1 : 0
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ssm_manager[0].id
  source_security_group_id = aws_security_group.ec2[0].id
}