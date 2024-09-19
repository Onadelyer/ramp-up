locals {
  vpc_id                   = var.vpc_id
  tags                     = var.tags
  ingress_with_cird_blocks = var.ingress_with_cird_blocks
  egress_with_cidr_blocks  = var.egress_with_cidr_blocks
}

resource "aws_security_group" "sg" {
  vpc_id = local.vpc_id

  dynamic "ingress" {
    for_each = local.ingress_with_cird_blocks
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = [ingress.value.cidr_blocks]
      description = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = local.egress_with_cidr_blocks
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = [egress.value.cidr_blocks]
      description = egress.value.description
    }
  }

  tags = local.tags
}

