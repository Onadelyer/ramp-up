module "vpc" {
  source = "./modules/vpc"

  name                        = "ramp-up"
  vpc_cidr                    = "192.168.0.0/16"
  azs                         = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets_cidr_blocks  = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  private_subnets_cidr_blocks = []
  tags                        = {}
}

module "security_groups" {
  source = "./modules/security-groups"

  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "ramp-up_sample_sg"
  }

  ingress_with_cird_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH"
      cidr_blocks = "10.0.0.0/8"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allow HTTP"
      cidr_blocks = "10.0.0.0/8"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound traffic"
      cidr_blocks = "10.0.0.0/8"
    },
  ]
}
