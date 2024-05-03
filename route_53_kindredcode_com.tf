# ------------------------------------------------------------------------------------------
# kindredcode.com

resource "aws_route53_record" "kindredcode_com__SOA" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "kindredcode.com"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["kindredcode.com"].name_servers[0]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "kindredcode_com__NS" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "kindredcode.com"
  type    = "NS"
  ttl     = "172800"
  records = [
    "${aws_route53_zone.hosted_zones["kindredcode.com"].name_servers[0]}.",
    "${aws_route53_zone.hosted_zones["kindredcode.com"].name_servers[1]}.",
    "${aws_route53_zone.hosted_zones["kindredcode.com"].name_servers[2]}.",
    "${aws_route53_zone.hosted_zones["kindredcode.com"].name_servers[3]}.",
  ]
}

resource "aws_route53_record" "kindredcode_com__A" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "kindredcode.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.kindredcode_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_kindredcode_com__A" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "www.kindredcode.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.kindredcode_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "mta_sts_kindredcode_com__A" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "mta-sts.kindredcode.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.mta_sts_kindredcode_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "kindredcode_com__MX" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "kindredcode.com"
  type    = "MX"
  ttl     = "3600"
  records = [
    "1 SMTP.GOOGLE.COM",
  ]
}

resource "aws_route53_record" "kindredcode_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "kindredcode.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 include:_spf.google.com ~all",
    "google-site-verification=iCA61zpmcK-WMakf4kxbB4SCE2r0P1knduvt3skSHwY",
  ]
}

resource "aws_route53_record" "dmarc_kindredcode_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "_dmarc.kindredcode.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=reject; rua=mailto:dmarc@kindredcode.com,mailto:cantor-d@dmarc.report-uri.com; ruf=mailto:dmarc@kindredcode.com; fo=1; pct=100; adkim=s; aspf=s",
  ]
}

resource "aws_route53_record" "google_domainkey_kindredcode_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "google._domainkey.kindredcode.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCrvhdbY90xIbQsqyZLXYOeL7z7q55KLPHzFnaZ1k+WQ1BLaB/gZK6z9GzSaUNNfdnULLsBzd8D3zqFtsjpw+qQ+/B0wjY0NhuSrWx7DyjZYIRwyGa0aUc3LP+fNIdWf+E/v+EcxbMKQk7+NJFljp3zI4OBZTvOyxEkKSVCySkjBwIDAQAB",
  ]
}

resource "aws_route53_record" "smtp_tls_kindredcode_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "_smtp._tls.kindredcode.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=TLSRPTv1; rua=mailto:mta-sts@kindredcode.com,mailto:cantor-d@tlsrpt.report-uri.com",
  ]
}

resource "aws_route53_record" "mta_sts_kindredcode_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "_mta-sts.kindredcode.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=STSv1; id=20240503173153Z;",
  ]
}

resource "aws_route53_record" "github_challenge_kindredcode_kindredcode_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "_github-challenge-kindredcode.kindredcode.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "6bc9fd3749",
  ]
}
