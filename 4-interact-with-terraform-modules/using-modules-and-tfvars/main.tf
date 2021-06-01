provider "aws" {
}

module "tags" {
  source = "github.com/Tanok-Technologies/playground.git/modules/aws/commons/tags"
}

// terraform plan --var-file=stg.tfvars
// terraform apply --var-file=stg.tfvars
// terraform plan --var-file=prd.tfvars
// terraform apply --var-file=prd.tfvars
module "bucket_s3" {
  source       = "../../modules/aws/storage/s3"
  environment  = var.environment
  organization = var.organization
  project      = var.project
  resource     = var.resource
  tags         = module.tags.tags_commons
}