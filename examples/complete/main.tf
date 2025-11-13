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