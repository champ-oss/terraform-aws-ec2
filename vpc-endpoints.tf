resource "aws_vpc_endpoint" "ssm" {
  count               = var.enabled && var.create_ssm_endpoint ? 1 : 0
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.this[0].name}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_instance.this[0].subnet_id]
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.ssm_manager[0].id]
  tags = merge(local.tags, var.tags, {
    Name = "${var.git}-ssm-endpoint"
  })
}

resource "aws_vpc_endpoint" "ssm_messages" {
  count               = var.enabled && var.create_ssm_endpoint ? 1 : 0
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.this[0].name}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_instance.this[0].subnet_id]
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.ssm_manager[0].id]
  tags = merge(local.tags, var.tags, {
    Name = "${var.git}-ssm-messages-endpoint"
  })
}

resource "aws_vpc_endpoint" "ec2_messages" {
  count               = var.enabled && var.create_ssm_endpoint ? 1 : 0
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.this[0].name}.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_instance.this[0].subnet_id]
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.ssm_manager[0].id]
  tags = merge(local.tags, var.tags, {
    Name = "${var.git}-ec2-messages-endpoint"
  })
}