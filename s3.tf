locals {
  s3_buckets_csv = file("s3_buckets.csv")
  s3_buckets     = csvdecode(local.s3_buckets_csv)
}

# ------------------------------------------------------------------------------------------
# Account-Wide S3 Block Public Access settings

resource "aws_s3_account_public_access_block" "default" {
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ------------------------------------------------------------------------------------------
# S3 Buckets

resource "aws_s3_bucket" "s3_buckets" {
  for_each = { for bucket in local.s3_buckets : bucket.immutable_id => bucket }

  bucket = each.key
}

resource "aws_s3_bucket_acl" "s3_bucket_private_acls" {
  for_each = { for bucket in local.s3_buckets : bucket.immutable_id => bucket }

  bucket = aws_s3_bucket.s3_buckets[each.key].id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "policy_for_cloudfront_private_content" {
  for_each = { for bucket in local.s3_buckets : bucket.immutable_id => bucket
    if contains(local.websites[*].immutable_id, bucket.immutable_id)
  }

  bucket = aws_s3_bucket.s3_buckets[each.key].id
  policy = data.aws_iam_policy_document.policy_for_cloudfront_private_content[each.key].json
}

data "aws_iam_policy_document" "policy_for_cloudfront_private_content" {
  for_each = { for bucket in local.s3_buckets : bucket.immutable_id => bucket }

  policy_id = "PolicyForCloudFrontPrivateContent"
  statement {
    actions = [
      "s3:GetObject",
    ]
    principals {
      type = "AWS"
      identifiers = [
        aws_cloudfront_origin_access_identity.identities[each.key].iam_arn,
      ]
    }
    resources = [
      "${aws_s3_bucket.s3_buckets[each.key].arn}/*",
    ]
    sid = "1"
  }
}
