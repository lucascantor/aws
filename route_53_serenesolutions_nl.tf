# ------------------------------------------------------------------------------------------
# serenesolutions.nl

resource "aws_route53_record" "serenesolutions_nl__SOA" {
  zone_id = aws_route53_zone.hosted_zones["serenesolutions.nl"].zone_id
  name    = "serenesolutions.nl"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["serenesolutions.nl"].name_servers[1]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "serenesolutions_nl__NS" {
  zone_id = aws_route53_zone.hosted_zones["serenesolutions.nl"].zone_id
  name    = "serenesolutions.nl"
  type    = "NS"
  ttl     = "172800"
  records = [
    "${aws_route53_zone.hosted_zones["serenesolutions.nl"].name_servers[0]}.",
    "${aws_route53_zone.hosted_zones["serenesolutions.nl"].name_servers[1]}.",
    "${aws_route53_zone.hosted_zones["serenesolutions.nl"].name_servers[2]}.",
    "${aws_route53_zone.hosted_zones["serenesolutions.nl"].name_servers[3]}.",
  ]
}

resource "aws_route53_record" "serenesolutions_nl__A" {
  zone_id = aws_route53_zone.hosted_zones["serenesolutions.nl"].zone_id
  name    = "serenesolutions.nl"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.serenesolutions_nl.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_serenesolutions_nl__A" {
  zone_id = aws_route53_zone.hosted_zones["serenesolutions.nl"].zone_id
  name    = "www.serenesolutions.nl"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.serenesolutions_nl.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "serenesolutions_nl__MX" {
  zone_id = aws_route53_zone.hosted_zones["serenesolutions.nl"].zone_id
  name    = "serenesolutions.nl"
  type    = "MX"
  ttl     = "3600"
  records = [
    "1 SMTP.GOOGLE.COM",
  ]
}

resource "aws_route53_record" "serenesolutions_nl__TXT" {
  zone_id = aws_route53_zone.hosted_zones["serenesolutions.nl"].zone_id
  name    = "serenesolutions.nl"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 include:_spf.google.com ~all",
    "google-site-verification=lvjsUqWjaukRQiH7sv9mGyB57rr03CVDJx3V9IcNWBM",
  ]
}

resource "aws_route53_record" "dmarc_serenesolutions_nl__TXT" {
  zone_id = aws_route53_zone.hosted_zones["serenesolutions.nl"].zone_id
  name    = "_dmarc.serenesolutions.nl"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=reject; rua=mailto:dmarc@serenesolutions.nl,mailto:cantor-d@dmarc.report-uri.com,mailto:3bb7ee9fe7cbd3cd3bfe059a02609870@snowy-hill-2286.tines.email; ruf=mailto:dmarc@serenesolutions.nl; fo=1; pct=100; adkim=s; aspf=s",
  ]
}

resource "aws_route53_record" "google_domainkey_serenesolutions_nl__TXT" {
  zone_id = aws_route53_zone.hosted_zones["serenesolutions.nl"].zone_id
  name    = "google._domainkey.serenesolutions.nl"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCgwCEE2v233Wf8QO7eJrBfzFLGNrgwJmXbCKHpKm2yzjeGgPAsLwQLInMLLgvOcDZb0L54s1qfPhwdmI0QC4auZxf7rtRf+6+CsE0zCKtnJJSAcimLno/FbpUZx28M7/khubx/a3zfPFJxlTr7fkUg1ypb0KsUmaC1pE2WF5Ur7wIDAQAB",
  ]
}
