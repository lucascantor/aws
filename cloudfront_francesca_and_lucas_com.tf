# ------------------------------------------------------------------------------------------
# francesca-and-lucas.com

resource "aws_cloudfront_distribution" "francesca_and_lucas_com" {
  aliases = [
    "francesca-and-lucas.com",
    "www.francesca-and-lucas.com",
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
    response_headers_policy_id = aws_cloudfront_response_headers_policy.custom_response_headers_policy_legacy.id
    target_origin_id           = "S3-francesca-and-lucas.com"
    viewer_protocol_policy     = "redirect-to-https"
  }
  enabled         = true
  is_ipv6_enabled = true
  origin {
    domain_name = "francesca-and-lucas.com.s3.amazonaws.com"
    origin_id   = "S3-francesca-and-lucas.com"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.identities["francesca-and-lucas.com"].cloudfront_access_identity_path
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.francesca_and_lucas_com.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
}
