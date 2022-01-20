<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.7.0 |


## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl"></a> [acl](#input\_acl) | politica de acceso private, public-read, public-read-write, aws-exec-read, authenticated-read,  log-delivery-write | `string` | `"private"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Ambiente en el cual se crea el recurso | `string` | `"poc"` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Entidad a la que pertenece el recurso | `string` | `"tanok"` | no |
| <a name="input_project"></a> [project](#input\_project) | Proyecto para el cual se crea el recurso | `string` | `"tanok-study"` | no |
| <a name="input_resource"></a> [resource](#input\_resource) | Uso del recurso a crear (bucket , appweb) | `string` | `"bucket"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to resources created with this module | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | n/a |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | n/a |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | n/a |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | n/a |
<!-- END_TF_DOCS -->
