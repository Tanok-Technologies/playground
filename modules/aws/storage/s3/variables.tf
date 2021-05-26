variable "environment" {
  description = "Ambiente en el cual se crea el recurso"
  default     = "poc"
}
variable "organization" {
  description = "Entidad a la que pertenece el recurso"
  default     = "tanok"
}
variable "project" {
  description = "Proyecto para el cual se crea el recurso"
  default     = "tanok-study"
}
variable "resource" {
  description = "Uso del recurso a crear (bucket , appweb)"
  default     = "bucket"
}
variable "acl" {
  description = "politica de acceso private, public-read, public-read-write, aws-exec-read, authenticated-read,  log-delivery-write"
  default     = "private"
}
variable "tags" {
  description = "Tags applied to resources created with this module"
  type        = map(any)
  default     = {}
}
locals {
  common_tags = merge({Name = "${var.environment}-${var.project}-${var.resource}-s3"},var.tags,)
}
