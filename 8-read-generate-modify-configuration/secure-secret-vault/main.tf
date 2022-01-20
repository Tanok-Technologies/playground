/**
  @Autor: jeisson.osoriob@gmail.com
  @Date: Junio 2021
  @Organization: Tanok Tech
  @Description: Template de prueba para uso de HashiCorp Vault
**/


// Inicio uso de HashisCorp Vault
// Para esta prueba en Vault existe un secret engine con el path (aws/secrets) y un secreto con el nombre (tanok)
// vault server -dev
// vault server -dev -dev-root-token-id="estudio"
/*
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN="estudio"
*/
provider "vault" {}

data "vault_generic_secret" "tanok_secrets" {
  path = "tanok/secrets/bd"
}
output "vault_user" {
  value     = data.vault_generic_secret.tanok_secrets.data["user"]
  sensitive = true
}
output "vault_pass" {
  value     = data.vault_generic_secret.tanok_secrets.data["pass"]
  sensitive = true
}
// terraform output -json
// Fin Vault
