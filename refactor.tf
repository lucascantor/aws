moved {
  from = aws_cloudfront_response_headers_policy.custom_security_headers_policy
  to   = aws_cloudfront_response_headers_policy.custom_response_headers_policy_legacy
}

moved {
  from = aws_cloudfront_response_headers_policy.custom_security_headers_cdn_policy
  to   = aws_cloudfront_response_headers_policy.custom_response_headers_policy_cdn
}
