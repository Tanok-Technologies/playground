########################
### Inputs Variables  ##
########################
variable "environment" {
  description = "Ambiente en el cual se esta ejecutando el proyecto y se desea crear el recurso"
  type        = string
  default     = "sandbox"
}
variable "organization" {
  description = "Entidad / Organizacion dueña del proyecto"
  type        = string
  default     = "poc"
}
variable "project" {
  description = "Proyecto para el cual se crea el recurso"
  type        = string
  default     = "tanok"
}
variable "resource" {
  description = "Recurso asociado a la creacion del modulo"
  type        = string
  default     = "object"
}
variable "policy_path" {
  description = "Path in which to create the policy"
  type        = string
  default     = "/service-role/"
}
variable "dynamo_table_arn" {
  description = "ARN de la tabla de dynamo de la cual se quiere realizar el Backup"
  type        = string
}
variable "dynamo_table_name" {
  description = "nombre de la tabla de dynamo de la cual se quiere realizar el Backup"
  type        = string
}

variable "force_detach_policies" {
  description = "aws_iam_role: Whether to force detaching any policies the role has before destroying it"
  type        = bool
  default     = false
}
variable "dynamo_target_scan_all" {
  description = "aws_glue_crawler: Indicates whether to scan all the records, or to sample rows from the table. Scanning all the records can take a long time when the table is not a high throughput table."
  type        = bool
  default     = true
}
variable "dynamo_target_scan_rate" {
  description = "aws_glue_crawler: The percentage of the configured read capacity units to use by the AWS Glue crawler"
  type        = number
  default     = null
}
variable "crawler_lineage_settings" {
  description = "aws_glue_crawler: Specifies whether data lineage is enabled for the crawler (DISABLE , ENABLE)"
  type        = string
  default     = "DISABLE"
}
variable "recrawl_behavior" {
  description = "aws_glue_crawler: Specifies whether to crawl the entire dataset again or to crawl only folders that were added since the last crawler run. Valid Values are: CRAWL_EVERYTHING and CRAWL_NEW_FOLDERS_ONLY"
  type        = string
  default     = "CRAWL_EVERYTHING"
}
variable "delete_behavior" {
  description = "aws_glue_crawler: The deletion behavior when the crawler finds a deleted object. Valid values: LOG, DELETE_FROM_DATABASE, or DEPRECATE_IN_DATABASE"
  type        = string
  default     = "DEPRECATE_IN_DATABASE"
}
variable "update_behavior" {
  description = "aws_glue_crawler: The update behavior when the crawler finds a changed schema. Valid values: LOG or UPDATE_IN_DATABASE"
  type        = string
  default     = "UPDATE_IN_DATABASE"
}
variable "create_glue_table" {
  description = "aws_glue_catalog_table: Flag to create a aws_glue_catalog_table (true, false)"
  type        = bool
  default     = false
}
variable "table_retention" {
  description = "aws_glue_catalog_table: Retention time for this table"
  type        = number
  default     = 0
}
variable "table_type" {
  description = "aws_glue_catalog_table: Type of this table (EXTERNAL_TABLE, VIRTUAL_VIEW)"
  type        = string
  default     = "EXTERNAL_TABLE"
}
variable "compressed" {
  description = "aws_glue_catalog_table:storage_descriptor:compressed: Whether the data in the table is compressed"
  type        = bool
  default     = false
}
variable "parameters_classification" {
  description = "aws_glue_catalog_table:parameters:classification: Classification of table (dynamodb)"
  type        = string
  default     = "dynamodb"
}
variable "parameters_type_of_data" {
  description = "aws_glue_catalog_table:parameters:typeOfData: Type of data (table)"
  type        = string
  default     = "table"
}
variable "retention_in_days" {
  description = "aws_cloudwatch_log_group: Retention number days of logs in cloud watch log group"
  type        = number
  default     = 5
}
variable "max_capacity" {
  description = "aws_glue_job: The maximum number of AWS Glue data processing units (DPUs) that can be allocated when this job runs"
  type        = number
  default     = 10
}
variable "max_retries" {
  description = "aws_glue_job: The maximum number of times to retry this job if it fails"
  type        = number
  default     = 0
}
variable "job_timeout" {
  description = "aws_glue_job: The job timeout in minutes. The default is 2880 minutes (48 hours)."
  type        = number
  default     = 2880
}
variable "max_concurrent_runs" {
  description = "aws_glue_job:  The maximum number of concurrent runs allowed for a job. The default is 1."
  type        = number
  default     = 1
}
variable "s3_spark_logs_path" {
  description = "aws_glue_job: Path where spark will store events logs"
  type        = string
}
variable "s3_glue_job_script_path" {
  description = "aws_glue_job: Path where are stored the python script that going to uses glue's job"
  type        = string
}
variable "python_version" {
  description = "aws_glue_job: script python version"
  type        = string
  default     = "3"
}
variable "handler" {
  description = "aws_lambda_function: lambda handler to the function"
  type        = string
  default     = "lambda-function.lambda_handler"
}
variable "runtime" {
  description = "aws_lambda_function: execution runtime for the lambda function"
  type        = string
  default     = "python3.8"
}
variable "memory_size" {
  description = "aws_lambda_function: Memoria asignada a la funcion lambda"
  type        = number
  default     = 128
}
variable "lambda_timeout" {
  description = "aws_lambda_function: time in seconds for timeout"
  type        = number
  default     = 3
}

########################
### Variables Locales ##
########################
locals {
  crawler_policy = jsonencode(
    {
      Statement = [
        {
          Action = [
            "dynamodb:DescribeTable",
            "dynamodb:Scan",
          ]
          Effect   = "Allow"
          Resource = var.dynamo_table_arn // TODO: Change to variable
          Sid      = "FromTerraform"
        },
      ]
      Version = "2012-10-17"
    }
  )
  crawler_assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "glue.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
  lambda_assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "lambda.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
  lambda_policy = jsonencode(
    {
      Statement = [
        {
          Action   = "glue:StartJobRun"
          Effect   = "Allow"
          Resource = "*"
          Sid      = "FromTerraform"
        },
      ]
      Version = "2012-10-17"
    }
  )
  common_tags = (tomap({
    Environment  = var.environment
    Organization = var.organization
    Project      = var.project
  }))
  lambda_env_variables = { GLUE_JOB_NAME = "${var.project}-${var.resource}-job" }
}
