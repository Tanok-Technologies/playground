provider "aws" {
}
terraform {
  backend "local" {
    path = "local-backend-configuration/terraform.tfstate"
  }
}

module "tags" {
  source = "../../../../modules/aws/commons/tags"
}
module "bucket_s3" {
  source = "../../../../modules/aws/storage/s3"
  tags   = module.tags.tags_commons
}
