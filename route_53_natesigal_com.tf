# ------------------------------------------------------------------------------------------
# natesigal.com

resource "aws_route53_record" "natesigal_com__SOA" {
  zone_id = aws_route53_zone.hosted_zones["natesigal.com"].zone_id
  name    = "natesigal.com"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["natesigal.com"].name_servers[2]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "natesigal_com__NS" {
  zone_id = aws_route53_zone.hosted_zones["natesigal.com"].zone_id
  name    = "natesigal.com"
  type    = "NS"
  ttl     = "172800"
  records = [
    "${aws_route53_zone.hosted_zones["natesigal.com"].name_servers[0]}.",
    "${aws_route53_zone.hosted_zones["natesigal.com"].name_servers[1]}.",
    "${aws_route53_zone.hosted_zones["natesigal.com"].name_servers[2]}.",
    "${aws_route53_zone.hosted_zones["natesigal.com"].name_servers[3]}.",
  ]
}

resource "aws_route53_record" "natesigal_com__A" {
  zone_id = aws_route53_zone.hosted_zones["natesigal.com"].zone_id
  name    = "natesigal.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.nathanielsigal_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_natesigal_com__A" {
  zone_id = aws_route53_zone.hosted_zones["natesigal.com"].zone_id
  name    = "www.natesigal.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.nathanielsigal_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "natesigal_com__MX" {
  zone_id = aws_route53_zone.hosted_zones["natesigal.com"].zone_id
  name    = "natesigal.com"
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 .",
  ]
}

resource "aws_route53_record" "natesigal_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["natesigal.com"].zone_id
  name    = "natesigal.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 -all",
  ]
}

resource "aws_route53_record" "dmarc_natesigal_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["natesigal.com"].zone_id
  name    = "_dmarc.natesigal.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=reject; rua=mailto:dmarc@natesigal.com,mailto:cantor-d@dmarc.report-uri.com; ruf=mailto:dmarc@natesigal.com; fo=1; pct=100; adkim=s; aspf=s",
  ]
}

resource "aws_route53_record" "domainkey_natesigal_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["natesigal.com"].zone_id
  name    = "*._domainkey.natesigal.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; p=",
  ]
}
