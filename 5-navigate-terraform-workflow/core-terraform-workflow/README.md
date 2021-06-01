<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.7.0 |

## Modules

| Name | From |
|------|------|
| tags | github.com/Tanok-Technologies/playground.git/modules/aws/commons/tags |
| compute | github.com/Tanok-Technologies/playground.git/modules/aws/compute/ec2 |

## Resources

No Resources

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | Tipo de AMI | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_public_dns"></a> [instance\_public\_dns](#output\_instance\_public\_dns) | Dms publico de la instancia |
| <a name="output_instance_public_ip"></a> [instance\_public\_ip](#output\_instance\_public\_ip) | Ip publica de la instancia |
<!-- END_TF_DOCS -->