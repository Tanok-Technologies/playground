// Using env variables
//export CONSUL_HTTP_TOKEN=125d1546-65c0-cffc-5b3e-72c28711aed5
//export CONSUL_HTTP_ADDR=https://consul-cluster.consul.c1f12400-e362-452b-9aad-8c4824e85db1.aws.hashicorp.cloud
//export CONSUL_HTTP_SSL=true
//

/*
terraform {
  backend "consul" {
    address  = "https://consul-cluster.consul.c1f12400-e362-452b-9aad-8c4824e85db1.aws.hashicorp.cloud"    
    scheme   = "https"
    path     = "tf/terraform.tfstate"
    lock     = true
    gzip     = true
  }
}
*/

// Using file Partial content
terraform {
  backend "consul" {

  }
}