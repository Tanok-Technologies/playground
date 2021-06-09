import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from datetime import datetime
## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)
## @type: DataSource
## @args: [database = "events-db", table_name = "events", transformation_ctx = "DataSource0"]
## @return: DataSource0
## @inputs: []
DataSource0 = glueContext.create_dynamic_frame.from_catalog(database = "logs-db", table_name = "logs", transformation_ctx = "DataSource0")
## @type: ApplyMapping
## @args: [mappings = [("trace", "string", "trace", "string"), ("service", "string", "service", "string"), ("service_name", "string", "service_name", "string"), ("ip", "string", "ip", "string"), ("timestamp", "string", "timestamp", "string")], transformation_ctx = "Transform0"]
## @return: Transform0
## @inputs: [frame = DataSource0]
#Transform0 = ApplyMapping.apply(frame = DataSource0, mappings = [("trace", "string", "trace", "string"), ("service", "string", "service", "string"), ("service_name", "string", "service_name", "string"), ("ip", "string", "ip", "string"), ("timestamp", "string", "timestamp", "string")], transformation_ctx = "Transform0")

repartition = DataSource0.repartition(1)
## @type: DataSink
## @args: [connection_type = "s3", format = "csv", connection_options = {"path": "s3://bucket/AWSDynamoDB/Backups/", "partitionKeys": []}, transformation_ctx = "DataSink0"]
## @return: DataSink0
## @inputs: [frame = Transform0]
DataSink0 = glueContext.write_dynamic_frame.from_options(frame = repartition, connection_type = "s3", format = "csv", connection_options = {"path": "s3://dev-audit-logs-s3/AWSDynamoDB/Backups/"+ str(datetime.now()), "partitionKeys": []}, transformation_ctx = "DataSink0",
format_options={
    "quoteChar": -1,
    "separator": ";",
    "multiline": True,
    "escaper":"\n"
    })
job.commit()
