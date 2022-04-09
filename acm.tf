# ------------------------------------------------------------------------------------------
# lizzythepooch.com

resource "aws_acm_certificate" "lizzythepooch_com" {
  domain_name = "lizzythepooch.com"
  subject_alternative_names = [
    "*.lizzythepooch.com",
  ]
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "lizzythepooch_com" {
  certificate_arn         = aws_acm_certificate.lizzythepooch_com.arn
  validation_record_fqdns = [for record in aws_route53_record.lizzythepooch_com__cert_validation : record.fqdn]
}
