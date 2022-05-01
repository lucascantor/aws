# ------------------------------------------------------------------------------------------
# lizzythepooch.com

resource "aws_route53_record" "lizzythepooch_com__SOA" {
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
  name    = "lizzythepooch.com"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["lizzythepooch.com"].name_servers[1]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "lizzythepooch_com__NS" {
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
  name    = "lizzythepooch.com"
  type    = "NS"
  ttl     = "172800"
  records = [
    aws_route53_zone.hosted_zones["lizzythepooch.com"].name_servers[0],
    aws_route53_zone.hosted_zones["lizzythepooch.com"].name_servers[1],
    aws_route53_zone.hosted_zones["lizzythepooch.com"].name_servers[2],
    aws_route53_zone.hosted_zones["lizzythepooch.com"].name_servers[3],
  ]
}

resource "aws_route53_record" "lizzythepooch_com__A" {
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
  name    = "lizzythepooch.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.lizzythepooch_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_lizzythepooch_com__A" {
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
  name    = "www.lizzythepooch.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.lizzythepooch_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "lizzythepooch_com__MX" {
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
  name    = "lizzythepooch.com"
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 .",
  ]
}

resource "aws_route53_record" "lizzythepooch_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
  name    = "lizzythepooch.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 -all",
  ]
}

resource "aws_route53_record" "dmarc_lizzythepooch_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
  name    = "_dmarc.lizzythepooch.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1;p=reject;sp=reject;adkim=s;aspf=s;fo=1;rua=mailto:dmarc@lizzythepooch.com,mailto:dmarc@lizzythepooch.com",
  ]
}

resource "aws_route53_record" "domainkey_lizzythepooch_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
  name    = "*._domainkey.lizzythepooch.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; p=",
  ]
}
