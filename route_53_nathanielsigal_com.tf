# ------------------------------------------------------------------------------------------
# nathanielsigal.com

resource "aws_route53_record" "nathanielsigal_com__SOA" {
  zone_id = aws_route53_zone.hosted_zones["nathanielsigal.com"].zone_id
  name    = "nathanielsigal.com"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["nathanielsigal.com"].name_servers[2]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "nathanielsigal_com__NS" {
  zone_id = aws_route53_zone.hosted_zones["nathanielsigal.com"].zone_id
  name    = "nathanielsigal.com"
  type    = "NS"
  ttl     = "172800"
  records = [
    "${aws_route53_zone.hosted_zones["nathanielsigal.com"].name_servers[0]}.",
    "${aws_route53_zone.hosted_zones["nathanielsigal.com"].name_servers[1]}.",
    "${aws_route53_zone.hosted_zones["nathanielsigal.com"].name_servers[2]}.",
    "${aws_route53_zone.hosted_zones["nathanielsigal.com"].name_servers[3]}.",
  ]
}

resource "aws_route53_record" "nathanielsigal_com__A" {
  zone_id = aws_route53_zone.hosted_zones["nathanielsigal.com"].zone_id
  name    = "nathanielsigal.com"
  type    = "A"

  alias {
    name                   = var.cloudfront_distribution_domain_names["nathanielsigal.com"]
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_nathanielsigal_com__A" {
  zone_id = aws_route53_zone.hosted_zones["nathanielsigal.com"].zone_id
  name    = "www.nathanielsigal.com"
  type    = "A"

  alias {
    name                   = var.cloudfront_distribution_domain_names["nathanielsigal.com"]
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "nathanielsigal_com__MX" {
  zone_id = aws_route53_zone.hosted_zones["nathanielsigal.com"].zone_id
  name    = "nathanielsigal.com"
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 .",
  ]
}

resource "aws_route53_record" "nathanielsigal_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["nathanielsigal.com"].zone_id
  name    = "nathanielsigal.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 -all",
  ]
}

resource "aws_route53_record" "dmarc_nathanielsigal_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["nathanielsigal.com"].zone_id
  name    = "_dmarc.nathanielsigal.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1;p=reject;sp=reject;adkim=s;aspf=s;fo=1;rua=mailto:dmarc@nathanielsigal.com,mailto:dmarc@nathanielsigal.com",
  ]
}

resource "aws_route53_record" "domainkey_nathanielsigal_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["nathanielsigal.com"].zone_id
  name    = "*._domainkey.nathanielsigal.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; p=",
  ]
}
