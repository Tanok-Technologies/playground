module "tags" {
  source = "../../modules/aws/commons/tags"
}

module "compute" {
  source        = "../../modules/aws/compute/ec2"
  instance_type = "t3.micro"
  tags          = module.tags.tags_commons
  ami_id        = "ami-0cf6f5c8a62fa5da6"
  providers = {
    aws = aws.west
  }
}
