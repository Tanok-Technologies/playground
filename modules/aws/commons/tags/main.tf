

locals {
  common_tags = (tomap({
    environment = "poc"
    company     = "tanok tech"
    application = "tanok app"
  }))
}