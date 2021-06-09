import json
import os
import logging
import boto3

# Logger Config
logger = logging.getLogger()
logger.setLevel(logging.INFO)
# JOB Glue Client 
client = boto3.client('glue')
glueJobName = os.environ['GLUE_JOB_NAME']

# Lambda Function actions
def lambda_handler(event, context):
    logger.info('## Starting Job: ')
    response = client.start_job_run(JobName = glueJobName)
    logger.info('## Job Started: ' + glueJobName)
    logger.info('## Glue-Job Run ID: ' + response['JobRunId'])
    return response