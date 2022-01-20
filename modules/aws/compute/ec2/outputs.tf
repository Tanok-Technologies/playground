# Salidas del stack
output "instance_public_ip" {
  value       = aws_instance.web.public_ip
  description = "Ip publica de la instancia"
}
output "instance_public_dns" {
  value       = aws_instance.web.public_dns
  description = "Dms publico de la instancia"
}
