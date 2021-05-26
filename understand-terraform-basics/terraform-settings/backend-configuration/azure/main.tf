provider "aws" {
}
#When authenticating using the Azure CLI or a Service Principal 
terraform {
  backend "azurerm" {
    resource_group_name  = "POCTANOK"
    storage_account_name = "pocstorage"
    container_name       = "pocstorage"
    key                  = "terraform.tfstate"  
  }
}
module "tags" {
  source = "../../../../modules/aws/commons/tags"
}
module "bucket_s3" {
  source = "../../../../modules/aws/storage/s3"  
  tags   = module.tags.tags_commons
}
