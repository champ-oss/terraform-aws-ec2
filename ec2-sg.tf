resource "aws_security_group" "ec2" {
  count       = var.enabled ? 1 : 0
  name_prefix = var.git
  vpc_id      = var.vpc_id

  # no inbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
