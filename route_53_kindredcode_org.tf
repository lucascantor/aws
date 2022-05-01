# ------------------------------------------------------------------------------------------
# kindredcode.org

resource "aws_route53_record" "kindredcode_org__SOA" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.org"].zone_id
  name    = "kindredcode.org"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["kindredcode.org"].name_servers[1]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "kindredcode_org__NS" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.org"].zone_id
  name    = "kindredcode.org"
  type    = "NS"
  ttl     = "172800"
  records = [
    "${aws_route53_zone.hosted_zones["kindredcode.org"].name_servers[0]}.",
    "${aws_route53_zone.hosted_zones["kindredcode.org"].name_servers[1]}.",
    "${aws_route53_zone.hosted_zones["kindredcode.org"].name_servers[2]}.",
    "${aws_route53_zone.hosted_zones["kindredcode.org"].name_servers[3]}.",
  ]
}

resource "aws_route53_record" "kindredcode_org__A" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.org"].zone_id
  name    = "kindredcode.org"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.kindredcode_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_kindredcode_org__A" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.org"].zone_id
  name    = "www.kindredcode.org"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.kindredcode_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "kindredcode_org__MX" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.org"].zone_id
  name    = "kindredcode.org"
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 .",
  ]
}

resource "aws_route53_record" "kindredcode_org__TXT" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.org"].zone_id
  name    = "kindredcode.org"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 -all",
  ]
}

resource "aws_route53_record" "dmarc_kindredcode_org__TXT" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.org"].zone_id
  name    = "_dmarc.kindredcode.org"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1;p=reject;sp=reject;adkim=s;aspf=s;fo=1;rua=mailto:dmarc@kindredcode.org,mailto:dmarc@kindredcode.org",
  ]
}

resource "aws_route53_record" "domainkey_kindredcode_org__TXT" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.org"].zone_id
  name    = "*._domainkey.kindredcode.org"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; p=",
  ]
}
