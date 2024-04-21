# ------------------------------------------------------------------------------------------
# blakesigal.com

resource "aws_route53_record" "blakesigal_com__SOA" {
  zone_id = aws_route53_zone.hosted_zones["blakesigal.com"].zone_id
  name    = "blakesigal.com"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["blakesigal.com"].name_servers[2]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "blakesigal_com__NS" {
  zone_id = aws_route53_zone.hosted_zones["blakesigal.com"].zone_id
  name    = "blakesigal.com"
  type    = "NS"
  ttl     = "172800"
  records = [
    aws_route53_zone.hosted_zones["blakesigal.com"].name_servers[0],
    aws_route53_zone.hosted_zones["blakesigal.com"].name_servers[1],
    aws_route53_zone.hosted_zones["blakesigal.com"].name_servers[2],
    aws_route53_zone.hosted_zones["blakesigal.com"].name_servers[3],
  ]
}

resource "aws_route53_record" "blakesigal_com__A" {
  zone_id = aws_route53_zone.hosted_zones["blakesigal.com"].zone_id
  name    = "blakesigal.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.blakesigal_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_blakesigal_com__A" {
  zone_id = aws_route53_zone.hosted_zones["blakesigal.com"].zone_id
  name    = "www.blakesigal.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.blakesigal_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "blakesigal_com__MX" {
  zone_id = aws_route53_zone.hosted_zones["blakesigal.com"].zone_id
  name    = "blakesigal.com"
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 .",
  ]
}

resource "aws_route53_record" "blakesigal_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["blakesigal.com"].zone_id
  name    = "blakesigal.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 -all",
  ]
}

resource "aws_route53_record" "dmarc_blakesigal_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["blakesigal.com"].zone_id
  name    = "_dmarc.blakesigal.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=reject; rua=mailto:dmarc@blakesigal.com,mailto:cantor-d@dmarc.report-uri.com,mailto:3bb7ee9fe7cbd3cd3bfe059a02609870@snowy-hill-2286.tines.email; ruf=mailto:dmarc@blakesigal.com; fo=1; pct=100; adkim=s; aspf=s",
  ]
}

resource "aws_route53_record" "domainkey_blakesigal_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["blakesigal.com"].zone_id
  name    = "*._domainkey.blakesigal.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; p=",
  ]
}
