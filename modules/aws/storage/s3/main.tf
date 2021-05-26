
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.environment}-${var.project}-${var.resource}-s3"
  acl    = var.acl
  tags   = local.common_tags
}
