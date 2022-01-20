# AMI of the latest Amazon Linux 2
/*
data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }
}
*/
resource "aws_instance" "web" {
  ami           = var.ami_id //data.aws_ami.this.id
  instance_type = var.instance_type

  #tags
  tags = merge(
    var.tags,
    {
      # Se adiciona el nombre del recurso a los tags comunes
      name = "web-instance"
    }
  )
}
