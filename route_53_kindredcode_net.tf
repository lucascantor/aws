# ------------------------------------------------------------------------------------------
# kindredcode.net

resource "aws_route53_record" "kindredcode_net__SOA" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.net"].zone_id
  name    = "kindredcode.net"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["kindredcode.net"].name_servers[1]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "kindredcode_net__NS" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.net"].zone_id
  name    = "kindredcode.net"
  type    = "NS"
  ttl     = "172800"
  records = [
    "${aws_route53_zone.hosted_zones["kindredcode.net"].name_servers[0]}.",
    "${aws_route53_zone.hosted_zones["kindredcode.net"].name_servers[1]}.",
    "${aws_route53_zone.hosted_zones["kindredcode.net"].name_servers[2]}.",
    "${aws_route53_zone.hosted_zones["kindredcode.net"].name_servers[3]}.",
  ]
}

resource "aws_route53_record" "kindredcode_net__A" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.net"].zone_id
  name    = "kindredcode.net"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.kindredcode_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_kindredcode_net__A" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.net"].zone_id
  name    = "www.kindredcode.net"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.kindredcode_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "kindredcode_net__MX" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.net"].zone_id
  name    = "kindredcode.net"
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 .",
  ]
}

resource "aws_route53_record" "kindredcode_net__TXT" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.net"].zone_id
  name    = "kindredcode.net"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 -all",
  ]
}

resource "aws_route53_record" "dmarc_kindredcode_net__TXT" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.net"].zone_id
  name    = "_dmarc.kindredcode.net"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=reject; rua=mailto:dmarc@kindredcode.net,mailto:cantor-d@dmarc.report-uri.com; ruf=mailto:dmarc@kindredcode.net; fo=1; pct=100; adkim=s; aspf=s",
  ]
}

resource "aws_route53_record" "domainkey_kindredcode_net__TXT" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.net"].zone_id
  name    = "*._domainkey.kindredcode.net"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; p=",
  ]
}
