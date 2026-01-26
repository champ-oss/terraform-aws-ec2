data "aws_vpcs" "this" {
  tags = {
    purpose = "vega"
  }
}

data "aws_subnets" "this" {
  tags = {
    purpose = "vega"
    Type    = "Private"
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.this.ids[0]]
  }
}

module "this" {
  source                = "../../"
  private_subnet_ids    = data.aws_subnets.this.ids[0]
  vpc_id                = data.aws_vpcs.this.ids[0]
  ec2_user_data_script  = "ec2_user_data.sh"
  # execute aws describe images  \
  #  --owners amazon \
  #  --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" \
  #  --query 'Images[0].ImageId' \
  #  --output text to get ami id
  ami_id                = "ami-0335b5183d7713fee"
  delete_on_termination = true
  additional_ebs_volumes = [
    {
      device_name = "/dev/sdf"
      volume_size = 20
    },
    {
      device_name           = "/dev/sdg"
      volume_size           = 50
      volume_type           = "gp3"
    }
  ]
}