/**
  @Autor: jeisson.osoriob@gmail.com
  @Date: Junio 2021
  @Organization: Tanok Tech
  @Description: Template de prueba para uso de AWS Secrets Manager
**/
provider "aws" {}

// Inicio uso de AWS Secrets Manager
// Para esta prueba en AWS Secrets managger se creo un secreto con el id (poc-tanok-secret)
data "aws_secretsmanager_secret_version" "creds" {
  secret_id = "poc-tanok-secret"
}
output "secret_output" {
  value = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)["password"]
}
// Fin uso de AWS Secrets Manager
