provider "aws" {
}

module "tags" {
  source = "github.com/Tanok-Technologies/playground.git/modules/aws/commons/tags"
}

// Module documentation
// https://registry.terraform.io/modules/JeissonO/modules/aws/latest
module "modules" {
  source   = "JeissonO/modules/aws"
  version  = "0.0.3"
  s3       = true
  resource = "test"
  tags     = module.tags.tags_commons
}
// Module documentation
// https://registry.terraform.io/modules/JeissonO/network/aws/latest
module "network" {
  source  = "JeissonO/network/aws"
  version = "0.0.3"
  tags    = module.tags.tags_commons
}
