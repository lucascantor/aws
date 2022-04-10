locals {
  websites_csv = file("websites.csv")
  websites     = csvdecode(local.websites_csv)
}

# ------------------------------------------------------------------------------------------
# CloudFront origin access identities

resource "aws_cloudfront_origin_access_identity" "identities" {
  for_each = { for identity in local.websites : identity.immutable_id => identity }

  comment = "access-identity-${each.key}.s3.amazonaws.com"
}

# ------------------------------------------------------------------------------------------
# CloudFront functions

resource "aws_cloudfront_function" "url_rewrite" {
  name    = "url-rewrite"
  runtime = "cloudfront-js-1.0"
  comment = "Adds index.html to viewer requests if missing"
  publish = true
  code    = file("cloudfront_functions/url-rewrite.js")
}
