# ------------------------------------------------------------------------------------------
# S3 Bucket CORS configuration

resource "aws_s3_bucket_cors_configuration" "cdn_lucascantor_com_cors_configuration" {
  bucket = aws_s3_bucket.s3_buckets["cdn.lucascantor.com"].id

  cors_rule {
    allowed_headers = [
      "Authorization",
    ]
    allowed_methods = [
      "GET",
    ]
    allowed_origins = [
      "*",
    ]
    expose_headers  = []
    max_age_seconds = 3000
  }

  expected_bucket_owner = var.aws_account_id
}
