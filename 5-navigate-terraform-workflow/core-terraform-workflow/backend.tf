terraform {
  backend "remote" {
    organization = "tanok"

    workspaces {
      name = "default"
    }
  }
  required_version = ">= 0.13.0"
}