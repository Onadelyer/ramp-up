locals {
  ami                               = var.ami
  instance_type                     = var.instance_type
  tags                              = var.tags
  sg_id                             = var.sg_id
  subnet_id                         = var.subnet_id
  ssh_key_name                      = var.ssh_key_name
  root_volume_size                  = var.root_volume_size
  root_volume_type                  = var.root_volume_type
  root_volume_delete_on_termination = var.root_volume_delete_on_termination
  private_ip                        = var.private_ip
  network_interface_name            = var.network_interface_name
  ec2_encrypted                     = var.ec2_encrypted
  kms_key_id                        = var.kms_key
}

resource "aws_instance" "ec2" {
  ami             = local.ami
  instance_type   = local.instance_type
  subnet_id       = local.subnet_id
  security_groups = [local.sg_id]

  root_block_device {
    volume_size           = local.root_volume_size
    volume_type           = local.root_volume_type
    delete_on_termination = local.root_volume_delete_on_termination
    encrypted             = local.ec2_encrypted
    kms_key_id            = local.kms_key_id
  }

  key_name = local.ssh_key_name
  tags     = local.tags
}

resource "aws_network_interface" "eni" {
  subnet_id   = local.subnet_id
  private_ips = [local.private_ip]

  tags = {
    Name = local.network_interface_name
  }
}
