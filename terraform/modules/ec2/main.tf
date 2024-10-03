locals {
  ami           = var.ami
  instance_type = var.instance_type
  tags          = var.tags
  sg_id         = var.sg_id
  subnet_id     = var.subnet_id
  ssh_key_name  = var.ssh_key_name
}

resource "aws_instance" "ec2" {
  ami             = local.ami
  instance_type   = local.instance_type
  subnet_id       = local.subnet_id
  security_groups = [local.sg_id]

  key_name = local.ssh_key_name
  tags     = local.tags
}
