# Salidas del stack
output "instance_public_ip" {
  value       = module.compute.instance_public_ip
  description = "Ip publica de la instancia"
}
output "instance_public_dns" {
  value       = module.compute.instance_public_dns
  description = "Dms publico de la instancia"
}