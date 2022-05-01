# ------------------------------------------------------------------------------------------
# francesca-and-lucas.com

resource "aws_route53_record" "francesca_and_lucas_com__SOA" {
  zone_id = aws_route53_zone.hosted_zones["francesca-and-lucas.com"].zone_id
  name    = "francesca-and-lucas.com"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["francesca-and-lucas.com"].name_servers[3]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "francesca_and_lucas_com__NS" {
  zone_id = aws_route53_zone.hosted_zones["francesca-and-lucas.com"].zone_id
  name    = "francesca-and-lucas.com"
  type    = "NS"
  ttl     = "172800"
  records = [
    aws_route53_zone.hosted_zones["francesca-and-lucas.com"].name_servers[0],
    aws_route53_zone.hosted_zones["francesca-and-lucas.com"].name_servers[1],
    aws_route53_zone.hosted_zones["francesca-and-lucas.com"].name_servers[2],
    aws_route53_zone.hosted_zones["francesca-and-lucas.com"].name_servers[3],
  ]
}

resource "aws_route53_record" "francesca_and_lucas_com__A" {
  zone_id = aws_route53_zone.hosted_zones["francesca-and-lucas.com"].zone_id
  name    = "francesca-and-lucas.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.francesca_and_lucas_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_francesca_and_lucas_com__A" {
  zone_id = aws_route53_zone.hosted_zones["francesca-and-lucas.com"].zone_id
  name    = "www.francesca-and-lucas.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.francesca_and_lucas_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "francesca_and_lucas_com__MX" {
  zone_id = aws_route53_zone.hosted_zones["francesca-and-lucas.com"].zone_id
  name    = "francesca-and-lucas.com"
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 .",
  ]
}

resource "aws_route53_record" "francesca_and_lucas_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["francesca-and-lucas.com"].zone_id
  name    = "francesca-and-lucas.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 -all",
  ]
}

resource "aws_route53_record" "dmarc_francesca_and_lucas_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["francesca-and-lucas.com"].zone_id
  name    = "_dmarc.francesca-and-lucas.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1;p=reject;sp=reject;adkim=s;aspf=s;fo=1;rua=mailto:dmarc@francesca-and-lucas.com,mailto:dmarc@francesca-and-lucas.com",
  ]
}

resource "aws_route53_record" "domainkey_francesca_and_lucas_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["francesca-and-lucas.com"].zone_id
  name    = "*._domainkey.francesca-and-lucas.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; p=",
  ]
}
