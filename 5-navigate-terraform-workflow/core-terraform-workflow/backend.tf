terraform {
  backend "remote" {
    organization = "tanok"

    workspaces {
      name = "default"
    }
  }
}
