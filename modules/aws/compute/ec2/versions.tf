terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 3.7.0"
     // configuration_aliases = [aws.west]
    }
  }
}