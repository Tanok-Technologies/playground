/**
  @Autor: Jeisson Osorio
  @Date: Junio 2021
  @Description: Template de configuracion de recursos para generar export de tabla dynamo a S3 utilizando AWS Glue
  INFO: Validar uso de workspace para la implementacion de la presente plantilla
  terraform workspace dev, terraform workspace qa, terraform workspace prd
**/
resource "aws_glue_catalog_database" "database" {
  name = "${var.project}-${var.resource}-db"
}

resource "aws_iam_policy" "crawler_policy" {
  description = "This policy will be used for Glue Crawler and Job execution"
  name        = "${var.organization}-${var.environment}-glue-crawler-policy"
  path        = var.policy_path
  policy      = local.crawler_policy
}

resource "aws_iam_role" "crawler_role" {
  assume_role_policy    = local.crawler_assume_role_policy
  force_detach_policies = var.force_detach_policies
  managed_policy_arns = [
    aws_iam_policy.crawler_policy.arn,
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole",
  ]
  max_session_duration = 3600
  name                 = "${var.organization}-${var.environment}-glue-crawler-role"
  path                 = var.policy_path
  tags                 = merge({ Name = "${var.organization}-${var.environment}-glue-crawler-role" }, local.common_tags, )
}

resource "aws_glue_crawler" "crawler" {
  database_name = aws_glue_catalog_database.database.name
  name          = "${var.project}-${var.resource}-crawler"
  role          = aws_iam_role.crawler_role.arn
  dynamodb_target {
    path      = var.dynamo_table_name
    scan_all  = var.dynamo_target_scan_all
    scan_rate = var.dynamo_target_scan_rate
  }
  lineage_configuration {
    crawler_lineage_settings = var.crawler_lineage_settings
  }
  recrawl_policy {
    recrawl_behavior = var.recrawl_behavior
  }
  schema_change_policy {
    delete_behavior = var.delete_behavior
    update_behavior = var.update_behavior
  }
  tags = merge({ Name = "${var.project}-${var.resource}-crawler" }, local.common_tags, )
}

resource "aws_glue_catalog_table" "logs_table" {
  count         = var.create_glue_table == true ? 1 : 0
  database_name = aws_glue_catalog_database.database.name
  name          = "${var.project}-${var.resource}-table"
  retention     = var.table_retention
  table_type    = var.table_type

  storage_descriptor {
    compressed = var.compressed
    location   = var.dynamo_table_arn
    parameters = {
      "UPDATED_BY_CRAWLER" = aws_glue_crawler.crawler.name
      "classification"     = var.parameters_classification
      "typeOfData"         = var.parameters_type_of_data
    }
  }
}

resource "aws_cloudwatch_log_group" "glue_job_log_group" {
  name              = "${var.environment}-${var.project}-${var.resource}-log-group"
  retention_in_days = var.retention_in_days
}

resource "aws_glue_job" "glue_job" {
  default_arguments = {
    "--class"                            = "GlueApp"
    "--continuous-log-logGroup"          = aws_cloudwatch_log_group.glue_job_log_group.name
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-continuous-log-filter"     = "true"
    "--enable-glue-datacatalog"          = "true"
    "--enable-metrics"                   = "true"
    "--job-bookmark-option"              = "job-bookmark-enable"
    "--job-language"                     = "python"
    "--enable-spark-ui"                  = "true"
    "--spark-event-logs-path"            = var.s3_spark_logs_path

  }
  glue_version = "2.0"
  max_capacity = var.max_capacity
  max_retries  = var.max_retries
  name         = "${var.project}-${var.resource}-job"
  role_arn     = aws_iam_role.crawler_role.arn
  timeout      = var.job_timeout

  command {
    name            = "glueetl"
    python_version  = var.python_version
    script_location = var.s3_glue_job_script_path
  }
  execution_property {
    max_concurrent_runs = var.max_concurrent_runs
  }
  tags = merge({ Name = "${var.project}-${var.resource}-job" }, local.common_tags, )
}

resource "aws_iam_role" "lambda_to_glue" {
  assume_role_policy    = local.lambda_assume_role_policy
  force_detach_policies = var.force_detach_policies
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
  ]
  max_session_duration = 3600
  name                 = "${var.organization}-${var.environment}-lambda-glue-role"
  description          = "Allows Lambda functions to call AWS Glue Job"
  tags                 = merge({ Name = "${var.organization}-${var.environment}-lambda-glue-role" }, local.common_tags, )

  inline_policy {
    name   = "${var.organization}-${var.environment}-lambda-glue-policy"
    policy = local.lambda_policy
  }
}

resource "aws_lambda_function" "logs_backup" {
  filename      = "${path.module}/lambda-functions/lambda-function.zip"
  function_name = "${var.environment}-${var.project}-${var.resource}-backup-glue-job"
  role          = aws_iam_role.lambda_to_glue.arn
  handler       = var.handler
  runtime       = var.runtime
  timeout       = var.lambda_timeout
  memory_size   = var.memory_size
  environment {
    variables = local.lambda_env_variables
  }
  tags = merge({ Name = "${var.environment}-${var.project}-${var.resource}-backup-glue-job" }, local.common_tags, )
}

resource "aws_cloudwatch_event_rule" "dynamo_backups_event_rule" {
  description         = "Evento that start the backup process of Dynamo table: ${var.dynamo_table_name}"
  is_enabled          = true
  name                = "${var.environment}-${var.project}-${var.resource}-event"
  schedule_expression = "cron(00 01 ? * MON-SUN *)"
  tags                = merge({ Name = "${var.environment}-${var.project}-${var.resource}-event" }, local.common_tags, )
}
resource "aws_cloudwatch_event_target" "dynamo_backups_event_target" {
  arn  = aws_lambda_function.logs_backup.arn
  rule = aws_cloudwatch_event_rule.dynamo_backups_event_rule.id
}
