output "aws_glue_job_arn" {
    value = module.aws_glue_job.glue_job.arn
    description = "Amazon Resource Name (ARN) of Glue Job"  
}
output "aws_glue_job_id" {
    value = module.aws_glue_job.glue_job.id
    description = "Created Job name"  
}
output "aws_lambda_function_arn" {
    value = module.aws_lambda_function.logs_backup.arn
    description = "Amazon Resource Name (ARN) identifying your Lambda Function."  
}
output "aws_lambda_function_invoke_arn" {
    value = module.aws_lambda_function.logs_backup.invoke_arn
    description = "ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri."  
}
output "aws_cloudwatch_event_rule_id" {
   value = module.aws_cloudwatch_event_rule.dynamo_backups_event_rule.id
   description = "The name of created event rule"
}
output "aws_cloudwatch_log_group_arn" {
  value = module.aws_cloudwatch_log_group.glue_job_log_group.arn
  description = "The Amazon Resource Name (ARN) specifying the log group used for AWS Glue job"
}