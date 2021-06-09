
# Dynamo Table Export to S3

This module will create resources that are used to export a Dynamo Table to an S3 Bucket using AWS Glue 

## Changes Control

| Version | Date | Responsible | Comments | 
|--|--|--|--|
| v.1.0.0 | jun 08, 2021 8:00 pm | [Jeisson Osorio]() | Versión inicial |

## Content

- [Dynamo Table Export to S3](#dynamo-table-export-to-s3)
  - [Changes Control](#changes-control)
  - [Content](#content)
  - [Requirements](#requirements)
  - [Providers](#providers)
  - [Resources](#resources)
  - [Inputs](#inputs)
  - [Outputs](#outputs)
  - [Job Script](#job-script)
  - [Use of Module Example](#use-of-module-example)



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.dynamo_backups_event_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.dynamo_backups_event_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.glue_job_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_glue_catalog_database.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_database) | resource |
| [aws_glue_catalog_table.logs_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_table) | resource |
| [aws_glue_crawler.crawler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_crawler) | resource |
| [aws_glue_job.glue_job](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_job) | resource |
| [aws_iam_policy.crawler_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.crawler_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda_to_glue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lambda_function.logs_backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compressed"></a> [compressed](#input\_compressed) | aws\_glue\_catalog\_table:storage\_descriptor:compressed: Whether the data in the table is compressed | `bool` | `false` | no |
| <a name="input_crawler_lineage_settings"></a> [crawler\_lineage\_settings](#input\_crawler\_lineage\_settings) | aws\_glue\_crawler: Specifies whether data lineage is enabled for the crawler (DISABLE , ENABLE) | `string` | `"DISABLE"` | no |
| <a name="input_create_glue_table"></a> [create\_glue\_table](#input\_create\_glue\_table) | aws\_glue\_catalog\_table: Flag to create a aws\_glue\_catalog\_table (true, false) | `bool` | `false` | no |
| <a name="input_delete_behavior"></a> [delete\_behavior](#input\_delete\_behavior) | aws\_glue\_crawler: The deletion behavior when the crawler finds a deleted object. Valid values: LOG, DELETE\_FROM\_DATABASE, or DEPRECATE\_IN\_DATABASE | `string` | `"DEPRECATE_IN_DATABASE"` | no |
| <a name="input_dynamo_table_arn"></a> [dynamo\_table\_arn](#input\_dynamo\_table\_arn) | ARN de la tabla de dynamo de la cual se quiere realizar el Backup | `string` | n/a | yes |
| <a name="input_dynamo_table_name"></a> [dynamo\_table\_name](#input\_dynamo\_table\_name) | nombre de la tabla de dynamo de la cual se quiere realizar el Backup | `string` | n/a | yes |
| <a name="input_dynamo_target_scan_all"></a> [dynamo\_target\_scan\_all](#input\_dynamo\_target\_scan\_all) | aws\_glue\_crawler: Indicates whether to scan all the records, or to sample rows from the table. Scanning all the records can take a long time when the table is not a high throughput table. | `bool` | `true` | no |
| <a name="input_dynamo_target_scan_rate"></a> [dynamo\_target\_scan\_rate](#input\_dynamo\_target\_scan\_rate) | aws\_glue\_crawler: The percentage of the configured read capacity units to use by the AWS Glue crawler | `number` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Ambiente en el cual se esta ejecutando el proyecto y se desea crear el recurso | `string` | `"sandbox"` | no |
| <a name="input_force_detach_policies"></a> [force\_detach\_policies](#input\_force\_detach\_policies) | aws\_iam\_role: Whether to force detaching any policies the role has before destroying it | `bool` | `false` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | aws\_lambda\_function: lambda handler to the function | `string` | `"lambda-function.lambda_handler"` | no |
| <a name="input_job_timeout"></a> [job\_timeout](#input\_job\_timeout) | aws\_glue\_job: The job timeout in minutes. The default is 2880 minutes (48 hours). | `number` | `2880` | no |
| <a name="input_lambda_timeout"></a> [lambda\_timeout](#input\_lambda\_timeout) | aws\_lambda\_function: time in seconds for timeout | `number` | `3` | no |
| <a name="input_max_capacity"></a> [max\_capacity](#input\_max\_capacity) | aws\_glue\_job: The maximum number of AWS Glue data processing units (DPUs) that can be allocated when this job runs | `number` | `10` | no |
| <a name="input_max_concurrent_runs"></a> [max\_concurrent\_runs](#input\_max\_concurrent\_runs) | aws\_glue\_job:  The maximum number of concurrent runs allowed for a job. The default is 1. | `number` | `1` | no |
| <a name="input_max_retries"></a> [max\_retries](#input\_max\_retries) | aws\_glue\_job: The maximum number of times to retry this job if it fails | `number` | `0` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | aws\_lambda\_function: Memoria asignada a la funcion lambda | `number` | `128` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Entidad / Organizacion dueña del proyecto | `string` | `"poc"` | no |
| <a name="input_parameters_classification"></a> [parameters\_classification](#input\_parameters\_classification) | aws\_glue\_catalog\_table:parameters:classification: Classification of table (dynamodb) | `string` | `"dynamodb"` | no |
| <a name="input_parameters_type_of_data"></a> [parameters\_type\_of\_data](#input\_parameters\_type\_of\_data) | aws\_glue\_catalog\_table:parameters:typeOfData: Type of data (table) | `string` | `"table"` | no |
| <a name="input_policy_path"></a> [policy\_path](#input\_policy\_path) | Path in which to create the policy | `string` | `"/service-role/"` | no |
| <a name="input_project"></a> [project](#input\_project) | Proyecto para el cual se crea el recurso | `string` | `"tanok"` | no |
| <a name="input_python_version"></a> [python\_version](#input\_python\_version) | aws\_glue\_job: script python version | `string` | `"3"` | no |
| <a name="input_recrawl_behavior"></a> [recrawl\_behavior](#input\_recrawl\_behavior) | aws\_glue\_crawler: Specifies whether to crawl the entire dataset again or to crawl only folders that were added since the last crawler run. Valid Values are: CRAWL\_EVERYTHING and CRAWL\_NEW\_FOLDERS\_ONLY | `string` | `"CRAWL_EVERYTHING"` | no |
| <a name="input_resource"></a> [resource](#input\_resource) | Recurso asociado a la creacion del modulo | `string` | `"object"` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | aws\_cloudwatch\_log\_group: Retention number days of logs in cloud watch log group | `number` | `5` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | aws\_lambda\_function: execution runtime for the lambda function | `string` | `"python3.8"` | no |
| <a name="input_s3_glue_job_script_path"></a> [s3\_glue\_job\_script\_path](#input\_s3\_glue\_job\_script\_path) | aws\_glue\_job: Path where are stored the python script that going to uses glue's job | `string` | n/a | yes |
| <a name="input_s3_spark_logs_path"></a> [s3\_spark\_logs\_path](#input\_s3\_spark\_logs\_path) | aws\_glue\_job: Path where spark will store events logs | `string` | n/a | yes |
| <a name="input_table_retention"></a> [table\_retention](#input\_table\_retention) | aws\_glue\_catalog\_table: Retention time for this table | `number` | `0` | no |
| <a name="input_table_type"></a> [table\_type](#input\_table\_type) | aws\_glue\_catalog\_table: Type of this table (EXTERNAL\_TABLE, VIRTUAL\_VIEW) | `string` | `"EXTERNAL_TABLE"` | no |
| <a name="input_update_behavior"></a> [update\_behavior](#input\_update\_behavior) | aws\_glue\_crawler: The update behavior when the crawler finds a changed schema. Valid values: LOG or UPDATE\_IN\_DATABASE | `string` | `"UPDATE_IN_DATABASE"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_cloudwatch_event_rule_id"></a> [aws\_cloudwatch\_event\_rule\_id](#output\_aws\_cloudwatch\_event\_rule\_id) | The name of created event rule |
| <a name="output_aws_cloudwatch_log_group_arn"></a> [aws\_cloudwatch\_log\_group\_arn](#output\_aws\_cloudwatch\_log\_group\_arn) | The Amazon Resource Name (ARN) specifying the log group used for AWS Glue job |
| <a name="output_aws_glue_job_arn"></a> [aws\_glue\_job\_arn](#output\_aws\_glue\_job\_arn) | Amazon Resource Name (ARN) of Glue Job |
| <a name="output_aws_glue_job_id"></a> [aws\_glue\_job\_id](#output\_aws\_glue\_job\_id) | Created Job name |
| <a name="output_aws_lambda_function_arn"></a> [aws\_lambda\_function\_arn](#output\_aws\_lambda\_function\_arn) | Amazon Resource Name (ARN) identifying your Lambda Function. |
| <a name="output_aws_lambda_function_invoke_arn"></a> [aws\_lambda\_function\_invoke\_arn](#output\_aws\_lambda\_function\_invoke\_arn) | ARN to be used for invoking Lambda Function from API Gateway - to be used in aws\_api\_gateway\_integration's uri. |
<!-- END_TF_DOCS -->


## Job Script 

You need to create a script job in Python that will be used for the Glue Job that this module going to create.

```PY
import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from datetime import datetime
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

DataSource = glueContext.create_dynamic_frame.from_catalog(database = "${aws_glue_catalog_database.name}", table_name = "${dynamo_table_name}", transformation_ctx = "DataSource")

repartition = DataSource.repartition(1)
DataSink0 = glueContext.write_dynamic_frame.from_options(frame = repartition, connection_type = "s3", format = "csv", connection_options = {"path": "${s3_backups.path}"+ str(datetime.now()), "partitionKeys": []}, transformation_ctx = "DataSink0",
format_options={
    "quoteChar": -1,
    "separator": ";",
    "multiline": True,
    "escaper":"\n"
    })
job.commit()

```

> This jobs must be stored in a S3 Bucket in your account and you need to pass the file path as variable in **S3_glue_job_script_path** 

## Use of Module Example

```js
module "dynamo_export" {
  source                    = "../dynamo-export-to-s3"  
  resource                  = "table"
  dynamo_table_arn          = "arn:aws:dynamodb:us-east-2:111122223333:table/table"
  dynamo_table_name         = "dynamo-table"
  s3_spark_logs_path        = "s3://{bucket-name}/{logs-path}/"
  s3_glue_job_script_path   = "s3://{bucket-name}/{script-path}/{script-file}"
}
```