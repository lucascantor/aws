# ------------------------------------------------------------------------------------------
# ronaldcantor.com

resource "aws_route53_record" "ronaldcantor_com__SOA" {
  zone_id = aws_route53_zone.hosted_zones["ronaldcantor.com"].zone_id
  name    = "ronaldcantor.com"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["ronaldcantor.com"].name_servers[0]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "ronaldcantor_com__NS" {
  zone_id = aws_route53_zone.hosted_zones["ronaldcantor.com"].zone_id
  name    = "ronaldcantor.com"
  type    = "NS"
  ttl     = "172800"
  records = [
    "${aws_route53_zone.hosted_zones["ronaldcantor.com"].name_servers[0]}.",
    "${aws_route53_zone.hosted_zones["ronaldcantor.com"].name_servers[1]}.",
    "${aws_route53_zone.hosted_zones["ronaldcantor.com"].name_servers[2]}.",
    "${aws_route53_zone.hosted_zones["ronaldcantor.com"].name_servers[3]}.",
  ]
}

resource "aws_route53_record" "ronaldcantor_com__A" {
  zone_id = aws_route53_zone.hosted_zones["ronaldcantor.com"].zone_id
  name    = "ronaldcantor.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.ronaldcantor_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_ronaldcantor_com__A" {
  zone_id = aws_route53_zone.hosted_zones["ronaldcantor.com"].zone_id
  name    = "www.ronaldcantor.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.ronaldcantor_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "ronaldcantor_com__MX" {
  zone_id = aws_route53_zone.hosted_zones["ronaldcantor.com"].zone_id
  name    = "ronaldcantor.com"
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 .",
  ]
}

resource "aws_route53_record" "ronaldcantor_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["ronaldcantor.com"].zone_id
  name    = "ronaldcantor.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 -all",
  ]
}

resource "aws_route53_record" "dmarc_ronaldcantor_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["ronaldcantor.com"].zone_id
  name    = "_dmarc.ronaldcantor.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1;p=reject;sp=reject;adkim=s;aspf=s;fo=1;rua=mailto:dmarc@ronaldcantor.com,mailto:dmarc@ronaldcantor.com",
  ]
}

resource "aws_route53_record" "domainkey_ronaldcantor_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["ronaldcantor.com"].zone_id
  name    = "*._domainkey.ronaldcantor.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; p=",
  ]
}
