resource "aws_instance" "this" {
  count                       = var.enabled ? 1 : 0
  ami                         = var.ami_id != null ? var.ami_id : data.aws_ami.this[0].id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_ids
  vpc_security_group_ids      = [aws_security_group.ec2[0].id]
  iam_instance_profile        = aws_iam_instance_profile.this[0].name
  associate_public_ip_address = false
  root_block_device {
    encrypted             = true
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    delete_on_termination = var.delete_on_termination
    # Conditionally use an existing root volume
    volume_id = var.existing_root_volume_id != null ? var.existing_root_volume_id : null
  }
  # variable file script name
  user_data = file("${path.module}/${var.ec2_user_data_script}")
  tags = merge(local.tags, var.tags, {
    Name = var.git
  })
}

resource "aws_iam_instance_profile" "this" {
  count = var.enabled ? 1 : 0
  name  = var.git
  role  = aws_iam_role.this[0].name
}