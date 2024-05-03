# ------------------------------------------------------------------------------------------
# centerpointwest.com

resource "aws_cloudfront_distribution" "centerpointwest_com" {
  aliases = [
    "centerpointwest.com",
    "www.centerpointwest.com",
    "beta.centerpointwest.com",
    "centerpointwestapartments.com",
    "www.centerpointwestapartments.com",
  ]
  custom_error_response {
    error_caching_min_ttl = 60
    error_code            = 403
    response_code         = 404
    response_page_path    = "/404.html"
  }
  custom_error_response {
    error_caching_min_ttl = 60
    error_code            = 404
    response_code         = 404
    response_page_path    = "/404.html"
  }
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
    cache_policy_id = local.managed_cloudfront_caching_optimized_policy_id
    compress        = true
    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.url_rewrite.arn
    }
    response_headers_policy_id = aws_cloudfront_response_headers_policy.custom_response_headers_policy_default.id
    target_origin_id           = "S3-centerpointwest.com"
    viewer_protocol_policy     = "redirect-to-https"
  }
  enabled         = true
  is_ipv6_enabled = true
  origin {
    domain_name = "centerpointwest.com.s3.amazonaws.com"
    origin_id   = "S3-centerpointwest.com"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.identities["centerpointwest.com"].cloudfront_access_identity_path
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.centerpointwest_com.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
}

# ------------------------------------------------------------------------------------------
# mta-sts.centerpointwest.com

resource "aws_cloudfront_distribution" "mta_sts_centerpointwest_com" {
  aliases = [
    "mta-sts.centerpointwest.com",
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
    target_origin_id           = "S3-mta-sts.centerpointwest.com"
    viewer_protocol_policy     = "redirect-to-https"
  }
  enabled         = true
  is_ipv6_enabled = true
  origin {
    domain_name = "mta-sts.centerpointwest.com.s3.amazonaws.com"
    origin_id   = "S3-mta-sts.centerpointwest.com"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.identities["mta-sts.centerpointwest.com"].cloudfront_access_identity_path
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.centerpointwest_com.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
}

# ------------------------------------------------------------------------------------------
# mta-sts.centerpointwestapartments.com

resource "aws_cloudfront_distribution" "mta_sts_centerpointwestapartments_com" {
  aliases = [
    "mta-sts.centerpointwestapartments.com",
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
    target_origin_id           = "S3-mta-sts.centerpointwestapartments.com"
    viewer_protocol_policy     = "redirect-to-https"
  }
  enabled         = true
  is_ipv6_enabled = true
  origin {
    domain_name = "mta-sts.centerpointwestapartments.com.s3.amazonaws.com"
    origin_id   = "S3-mta-sts.centerpointwestapartments.com"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.identities["mta-sts.centerpointwestapartments.com"].cloudfront_access_identity_path
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.centerpointwest_com.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
}
