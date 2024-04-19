locals {
  websites_csv                                   = file("websites.csv")
  websites                                       = csvdecode(local.websites_csv)
  managed_cloudfront_caching_optimized_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
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

resource "aws_cloudfront_response_headers_policy" "custom_response_headers_policy_default" {
  name    = "CustomResponseHeadersPolicyDefault"
  comment = "Adds a set of security headers to every response, and a Report-To header to report violations to a specified URL"

  security_headers_config {
    content_security_policy {
      content_security_policy = var.content_security_policy.default
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

  custom_headers_config {
    items {
      header   = "Report-To"
      value    = var.report_to_response_header
      override = true
    }

    items {
      header   = "NEL"
      value    = var.nel_response_header
      override = true
    }
  }
}

resource "aws_cloudfront_response_headers_policy" "custom_response_headers_policy_legacy" {
  name    = "CustomResponseHeadersPolicyLegacy"
  comment = "Adds a set of security headers to every response"

  security_headers_config {
    content_security_policy {
      content_security_policy = var.content_security_policy.legacy
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

resource "aws_cloudfront_response_headers_policy" "custom_response_headers_policy_cdn" {
  name    = "CustomResponseHeadersPolicyCDN"
  comment = "Adds a set of security headers to every response, and an X-Robots-Tag header to prevent indexing"

  security_headers_config {
    content_security_policy {
      content_security_policy = var.content_security_policy.legacy
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

  custom_headers_config {
    items {
      header   = "X-Robots-Tag"
      value    = "noindex"
      override = true
    }

    items {
      header   = "Report-To"
      value    = var.report_to_response_header
      override = true
    }

    items {
      header   = "NEL"
      value    = var.nel_response_header
      override = true
    }
  }
}
