# ------------------------------------------------------------------------------------------
# serenesolutions.nl

resource "aws_cloudfront_distribution" "serenesolutions_nl" {
  aliases = [
    "serenesolutions.nl",
    "www.serenesolutions.nl",
  ]
  default_root_object = "index.html"
  default_cache_behavior {
    allowed_methods = [
      "GET",
      "HEAD",
    ]
    cached_methods = [
      "GET",
      "HEAD",
    ]
    cache_policy_id            = local.managed_cloudfront_caching_optimized_policy_id
    compress                   = true
    response_headers_policy_id = aws_cloudfront_response_headers_policy.custom_response_headers_policy_default.id
    target_origin_id           = "S3-serenesolutions.nl"
    viewer_protocol_policy     = "redirect-to-https"
  }
  enabled         = true
  is_ipv6_enabled = true
  origin {
    domain_name = "serenesolutions.nl.s3.amazonaws.com"
    origin_id   = "S3-serenesolutions.nl"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.identities["serenesolutions.nl"].cloudfront_access_identity_path
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.serenesolutions_nl.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
}

# ------------------------------------------------------------------------------------------
# mta-sts.serenesolutions.nl

resource "aws_cloudfront_distribution" "mta_sts_serenesolutions_nl" {
  aliases = [
    "mta-sts.serenesolutions.nl",
  ]
  default_root_object = "index.html"
  default_cache_behavior {
    allowed_methods = [
      "GET",
      "HEAD",
    ]
    cached_methods = [
      "GET",
      "HEAD",
    ]
    cache_policy_id            = local.managed_cloudfront_caching_optimized_policy_id
    compress                   = true
    response_headers_policy_id = aws_cloudfront_response_headers_policy.custom_response_headers_policy_cdn.id
    target_origin_id           = "S3-mta-sts.serenesolutions.nl"
    viewer_protocol_policy     = "redirect-to-https"
  }
  enabled         = true
  is_ipv6_enabled = true
  origin {
    domain_name = "mta-sts.serenesolutions.nl.s3.amazonaws.com"
    origin_id   = "S3-mta-sts.serenesolutions.nl"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.identities["mta-sts.serenesolutions.nl"].cloudfront_access_identity_path
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.serenesolutions_nl.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
}
