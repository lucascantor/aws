# ------------------------------------------------------------------------------------------
# williamsigal.com

resource "aws_route53_record" "williamsigal_com__SOA" {
  zone_id = aws_route53_zone.hosted_zones["williamsigal.com"].zone_id
  name    = "williamsigal.com"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["williamsigal.com"].name_servers[2]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "williamsigal_com__NS" {
  zone_id = aws_route53_zone.hosted_zones["williamsigal.com"].zone_id
  name    = "williamsigal.com"
  type    = "NS"
  ttl     = "172800"
  records = [
    aws_route53_zone.hosted_zones["williamsigal.com"].name_servers[0],
    aws_route53_zone.hosted_zones["williamsigal.com"].name_servers[1],
    aws_route53_zone.hosted_zones["williamsigal.com"].name_servers[2],
    aws_route53_zone.hosted_zones["williamsigal.com"].name_servers[3],
  ]
}

resource "aws_route53_record" "williamsigal_com__A" {
  zone_id = aws_route53_zone.hosted_zones["williamsigal.com"].zone_id
  name    = "williamsigal.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.williamsigal_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_williamsigal_com__A" {
  zone_id = aws_route53_zone.hosted_zones["williamsigal.com"].zone_id
  name    = "www.williamsigal.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.williamsigal_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "williamsigal_com__MX" {
  zone_id = aws_route53_zone.hosted_zones["williamsigal.com"].zone_id
  name    = "williamsigal.com"
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 .",
  ]
}

resource "aws_route53_record" "williamsigal_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["williamsigal.com"].zone_id
  name    = "williamsigal.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 -all",
  ]
}

resource "aws_route53_record" "dmarc_williamsigal_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["williamsigal.com"].zone_id
  name    = "_dmarc.williamsigal.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1;p=reject;sp=reject;adkim=s;aspf=s;fo=1;rua=mailto:dmarc@williamsigal.com,mailto:dmarc@williamsigal.com",
  ]
}

resource "aws_route53_record" "domainkey_williamsigal_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["williamsigal.com"].zone_id
  name    = "*._domainkey.williamsigal.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; p=",
  ]
}
