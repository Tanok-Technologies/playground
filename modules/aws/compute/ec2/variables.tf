variable "tags" {
  default     = {}
  description = "Tags generales del modulo"
  type        = map(string)
}
variable "instance_type" {
  default     = "t3.micro"
  description = "Tipo de instancia a crear"
  type        = string
}
variable "ami_id" {
  description = "Tipo de AMI"
  type        = string
}
