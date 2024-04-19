# ------------------------------------------------------------------------------------------
# lucascantor.com

resource "aws_cloudfront_distribution" "lucascantor_com" {
  aliases = [
    "lucascantor.com",
    "www.lucascantor.com",
  ]
  custom_error_response {
    error_caching_min_ttl = 300
    error_code            = 403
    response_code         = 403
    response_page_path    = "/403.html"
  }
  custom_error_response {
    error_caching_min_ttl = 300
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
    target_origin_id           = "S3-lucascantor.com"
    viewer_protocol_policy     = "redirect-to-https"
  }
  enabled         = true
  is_ipv6_enabled = true
  origin {
    domain_name = "lucascantor.com.s3.amazonaws.com"
    origin_id   = "S3-lucascantor.com"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.identities["lucascantor.com"].cloudfront_access_identity_path
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.lucascantor_com.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
}

# ------------------------------------------------------------------------------------------
# blog.lucascantor.com

resource "aws_cloudfront_distribution" "blog_lucascantor_com" {
  aliases = [
    "blog.lucascantor.com",
  ]
  custom_error_response {
    error_caching_min_ttl = 300
    error_code            = 403
    response_code         = 403
    response_page_path    = "/403.html"
  }
  custom_error_response {
    error_caching_min_ttl = 300
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
    target_origin_id           = "S3-blog.lucascantor.com"
    viewer_protocol_policy     = "redirect-to-https"
  }
  enabled         = true
  is_ipv6_enabled = true
  origin {
    domain_name = "blog.lucascantor.com.s3.amazonaws.com"
    origin_id   = "S3-blog.lucascantor.com"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.identities["blog.lucascantor.com"].cloudfront_access_identity_path
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.lucascantor_com.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
}

# ------------------------------------------------------------------------------------------
# cdn.lucascantor.com

resource "aws_cloudfront_distribution" "cdn_lucascantor_com" {
  aliases = [
    "cdn.lucascantor.com",
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
    target_origin_id           = "S3-cdn.lucascantor.com"
    viewer_protocol_policy     = "redirect-to-https"
  }
  enabled         = true
  is_ipv6_enabled = true
  origin {
    domain_name = "cdn.lucascantor.com.s3.amazonaws.com"
    origin_id   = "S3-cdn.lucascantor.com"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.identities["cdn.lucascantor.com"].cloudfront_access_identity_path
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.lucascantor_com.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
}
