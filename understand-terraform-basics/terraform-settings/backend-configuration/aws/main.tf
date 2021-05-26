provider "aws" {
}
terraform {
  backend "s3" {
    bucket = "s3-aws-bucket-yeyo"
    key    = "terraform-settings/backend-configuration/terraform.tfstate"
    region = "us-east-2"
  }
}

module "tags" {
  source = "../../../../modules/aws/commons/tags"
}
module "bucket_s3" {
  source = "../../../../modules/aws/storage/s3"  
  tags   = module.tags.tags_commons
}
