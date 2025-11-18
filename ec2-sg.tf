resource "aws_security_group" "ec2" {
  count       = var.enabled ? 1 : 0
  name_prefix = var.git
  vpc_id      = var.vpc_id

  # default egress
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # optional extra ingress rules
  dynamic "ingress" {
    for_each = var.extra_ingress_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = lookup(ingress.value, "cidr_blocks", null)
      security_groups = lookup(ingress.value, "sg_ids", null)
      description     = lookup(ingress.value, "description", null)
    }
  }
}