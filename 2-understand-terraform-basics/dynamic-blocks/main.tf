provider "aws" {}

locals {
  ingress = [
    {
      from = 443
      to   = 443
    },
    {
      from = 80
      to   = 80
    },
    {
      from = 90
      to   = 90
    }
  ]
}
variable "vpc_id" {
  description = "Identificador de la vpc en la cual se creara el SG"
  type        = string
}


resource "aws_security_group" "allow_tls" {
  name        = "dynamic_block_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = local.ingress
    //iterator = ite
    content {
      description = ""
      //from_port   = ite.value.from // value, key
      //to_port     = ite.value.to
      from_port   = ingress.value.from // value, key
      to_port     = ingress.value.to
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}
