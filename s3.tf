locals {
  s3_buckets_csv = templatefile("s3_buckets.csv", {
    blakesigal_com_cloudfront_distribution_id                        = aws_cloudfront_distribution.blakesigal_com.id,
    blog_lucascantor_com_cloudfront_distribution_id                  = aws_cloudfront_distribution.blog_lucascantor_com.id,
    cantor_cloud_cloudfront_distribution_id                          = aws_cloudfront_distribution.cantor_cloud.id,
    cdn_lucascantor_com_cloudfront_distribution_id                   = aws_cloudfront_distribution.cdn_lucascantor_com.id,
    centerpointwest_com_cloudfront_distribution_id                   = aws_cloudfront_distribution.centerpointwest_com.id,
    francesca_and_lucas_com_cloudfront_distribution_id               = aws_cloudfront_distribution.francesca_and_lucas_com.id,
    hunterscreekapartments_net_cloudfront_distribution_id            = aws_cloudfront_distribution.hunterscreekapartments_net.id,
    kindredcode_com_cloudfront_distribution_id                       = aws_cloudfront_distribution.kindredcode_com.id,
    lizzythepooch_com_cloudfront_distribution_id                     = aws_cloudfront_distribution.lizzythepooch_com.id,
    lucascantor_com_cloudfront_distribution_id                       = aws_cloudfront_distribution.lucascantor_com.id,
    mta_sts_cantor_cloud_cloudfront_distribution_id                  = aws_cloudfront_distribution.mta_sts_cantor_cloud.id,
    mta_sts_centerpointwest_com_cloudfront_distribution_id           = aws_cloudfront_distribution.mta_sts_centerpointwest_com.id,
    mta_sts_centerpointwestapartments_com_cloudfront_distribution_id = aws_cloudfront_distribution.mta_sts_centerpointwestapartments_com.id,
    mta_sts_hunterscreekapartments_net_cloudfront_distribution_id    = aws_cloudfront_distribution.mta_sts_hunterscreekapartments_net.id,
    mta_sts_kindredcode_com_cloudfront_distribution_id               = aws_cloudfront_distribution.mta_sts_kindredcode_com.id,
    mta_sts_serenesolutions_nl_cloudfront_distribution_id            = aws_cloudfront_distribution.mta_sts_serenesolutions_nl.id,
    mta_sts_unitizer_com_cloudfront_distribution_id                  = aws_cloudfront_distribution.mta_sts_unitizer_com.id,
    nathanielsigal_com_cloudfront_distribution_id                    = aws_cloudfront_distribution.nathanielsigal_com.id,
    ronaldcantor_com_cloudfront_distribution_id                      = aws_cloudfront_distribution.ronaldcantor_com.id,
    serenesolutions_nl_cloudfront_distribution_id                    = aws_cloudfront_distribution.serenesolutions_nl.id,
    unitizer_com_cloudfront_distribution_id                          = aws_cloudfront_distribution.unitizer_com.id,
    williamsigal_com_cloudfront_distribution_id                      = aws_cloudfront_distribution.williamsigal_com.id,
  })
  s3_buckets      = csvdecode(local.s3_buckets_csv)
  mime_types_json = file("mime_types.json")
  mime_types      = jsondecode(local.mime_types_json)
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
  tags = {
    distribution_id = each.value.cloudfront_distribution_id
  }
}

# ------------------------------------------------------------------------------------------
# S3 Bucket notifications to invalidate associated CloudFront distributions

resource "aws_lambda_permission" "cloudfront_invalidation_lambda" {
  for_each = { for bucket in local.s3_buckets : bucket.immutable_id => bucket
    if contains(local.websites[*].immutable_id, bucket.immutable_id)
  }

  action              = "lambda:InvokeFunction"
  function_name       = aws_lambda_function.cloudfront_invalidation_lambda.arn
  principal           = "s3.amazonaws.com"
  source_account      = data.aws_caller_identity.current.account_id
  source_arn          = aws_s3_bucket.s3_buckets[each.key].arn
  statement_id_prefix = "cloudfront_invalidation_lambda_"
}

resource "aws_s3_bucket_notification" "cloudfront_invalidation_lambda" {
  for_each = { for bucket in local.s3_buckets : bucket.immutable_id => bucket
    if contains(local.websites[*].immutable_id, bucket.immutable_id)
  }

  bucket = each.key
  lambda_function {
    lambda_function_arn = aws_lambda_function.cloudfront_invalidation_lambda.arn
    events = [
      "s3:ObjectCreated:*",
      "s3:ObjectRemoved:*"
    ]
  }
  depends_on = [
    aws_lambda_function.cloudfront_invalidation_lambda,
    aws_lambda_permission.cloudfront_invalidation_lambda,
  ]
}

# ------------------------------------------------------------------------------------------
# S3 Bucket ACLs

resource "aws_s3_bucket_ownership_controls" "s3_bucket_ownership_controls" {
  for_each = { for bucket in local.s3_buckets : bucket.immutable_id => bucket }

  bucket = aws_s3_bucket.s3_buckets[each.key].id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# ------------------------------------------------------------------------------------------
# S3 Bucket policies for CloudFront private content

resource "aws_s3_bucket_policy" "policy_for_cloudfront_private_content" {
  for_each = { for bucket in local.s3_buckets : bucket.immutable_id => bucket
    if contains(local.websites[*].immutable_id, bucket.immutable_id)
  }

  bucket = aws_s3_bucket.s3_buckets[each.key].id
  policy = data.aws_iam_policy_document.policy_for_cloudfront_private_content[each.key].json
}

data "aws_iam_policy_document" "policy_for_cloudfront_private_content" {
  for_each = { for bucket in local.s3_buckets : bucket.immutable_id => bucket
    if contains(local.websites[*].immutable_id, bucket.immutable_id)
  }

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

# ------------------------------------------------------------------------------------------
# S3 objects for all websites

resource "aws_s3_object" "websites" {
  for_each = fileset("websites/", "**")

  bucket       = regex("^[^/]*", each.value)
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.value), null)
  etag         = filemd5("websites/${each.value}")
  key          = regex("/.*$", each.value)
  source       = "websites/${each.value}"
}
