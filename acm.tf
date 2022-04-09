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

# ------------------------------------------------------------------------------------------
# francesca-and-lucas.com

resource "aws_acm_certificate" "francesca_and_lucas_com" {
  domain_name = "francesca-and-lucas.com"
  subject_alternative_names = [
    "*.francesca-and-lucas.com",
  ]
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "francesca_and_lucas_com" {
  certificate_arn         = aws_acm_certificate.francesca_and_lucas_com.arn
  validation_record_fqdns = [for record in aws_route53_record.francesca_and_lucas_com__cert_validation : record.fqdn]
}

# ------------------------------------------------------------------------------------------
# nathanielsigal.com

resource "aws_acm_certificate" "nathanielsigal_com" {
  domain_name = "nathanielsigal.com"
  subject_alternative_names = [
    "*.nathanielsigal.com",
    "natesigal.com",
    "*.natesigal.com",
  ]
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "nathanielsigal_com" {
  certificate_arn         = aws_acm_certificate.nathanielsigal_com.arn
  validation_record_fqdns = [for record in aws_route53_record.nathanielsigal_com__cert_validation : record.fqdn]
}
