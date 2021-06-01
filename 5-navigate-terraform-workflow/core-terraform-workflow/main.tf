provider "aws" {
  region = "us-east-1"
}

module "tags" {
  source = "github.com/Tanok-Technologies/playground.git/modules/aws/commons/tags"
}

module "compute" {
  source        = "github.com/Tanok-Technologies/playground.git/modules/aws/compute/ec2"
  instance_type = "t3.micro"
  tags          = module.tags.tags_commons
  ami_id        = var.ami_id //variable id_ami para mostrar la consola
}