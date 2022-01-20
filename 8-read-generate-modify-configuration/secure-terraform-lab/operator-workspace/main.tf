variable "name" { default = "dynamic-aws-creds-operator" }
variable "region" { default = "us-east-2" }
variable "path" { default = "../vault-admin-workspace/terraform.tfstate" }
variable "ttl" { default = "1" }

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

data "terraform_remote_state" "admin" {
  backend = "local"

  config = {
    path = var.path
  }
}

data "vault_aws_access_credentials" "creds" {
  backend  = data.terraform_remote_state.admin.outputs.backend
  role     = data.terraform_remote_state.admin.outputs.role
  type     = "sts"
  ttl      = 3600
  role_arn = "arn:aws:iam::506080924848:role/default-terraform-role"
}

provider "aws" {
  region = var.region
  assume_role {
    role_arn = "arn:aws:iam::506080924848:role/default-terraform-role"
  }
  //access_key = data.vault_aws_access_credentials.creds.access_key
  //secret_key = data.vault_aws_access_credentials.creds.secret_key
}


module "tags" {
  source = "github.com/Tanok-Technologies/playground.git/modules/aws/commons/tags"
}
module "bucket_s3" {
  source = "github.com/Tanok-Technologies/playground.git/modules/aws/storage/s3"
  tags   = module.tags.tags_commons
}
