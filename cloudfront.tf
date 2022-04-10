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

# ------------------------------------------------------------------------------------------
# CloudFront response headers policies

resource "aws_cloudfront_response_headers_policy" "custom_security_headers_policy" {
  name    = "CustomSecurityHeadersPolicy"
  comment = "Adds a set of security headers to every response"

  security_headers_config {
    content_security_policy {
      content_security_policy = "default-src 'none'; object-src 'none'; base-uri 'none'; frame-ancestors 'none'; form-action 'none'; media-src 'self'; script-src 'self'; frame-src 'self'; img-src 'self' https://cdn.lucascantor.com; style-src 'self' https://cdn.lucascantor.com https://fonts.googleapis.com https://fonts.gstatic.com; font-src 'self' https://cdn.lucascantor.com https://fonts.googleapis.com https://fonts.gstatic.com"
      override                = true
    }
    content_type_options {
      override = true
    }
    frame_options {
      frame_option = "DENY"
      override     = true
    }
    referrer_policy {
      referrer_policy = "same-origin"
      override        = true
    }
    strict_transport_security {
      access_control_max_age_sec = 63072000
      include_subdomains         = true
      override                   = true
      preload                    = true
    }
    xss_protection {
      mode_block = true
      override   = true
      protection = true
    }
  }
}

# ------------------------------------------------------------------------------------------
# CloudFront cache policies

data "aws_cloudfront_cache_policy" "caching_optimized" {
  name = "CachingOptimized"
}
