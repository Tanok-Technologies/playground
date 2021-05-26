# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

module "tags" {
  source = "../../../../modules/aws/commons/tags"
}
module "bucket_s3" {
  source = "../../../../modules/aws/storage/s3"  
  tags   = module.tags.tags_commons
}
