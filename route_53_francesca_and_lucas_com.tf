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
    name                   = var.cloudfront_distribution_domain_names["francesca-and-lucas.com"]
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_francesca_and_lucas_com__A" {
  zone_id = aws_route53_zone.hosted_zones["francesca-and-lucas.com"].zone_id
  name    = "www.francesca-and-lucas.com"
  type    = "A"

  alias {
    name                   = var.cloudfront_distribution_domain_names["francesca-and-lucas.com"]
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

# ------------------------------------------------------------------------------------------
# francesca-and-lucas.com cert validation record(s)

resource "aws_route53_record" "francesca_and_lucas_com__cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.francesca_and_lucas_com.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if substr(dvo.domain_name, 0, 2) != "*."
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 300
  type    = each.value.type
  zone_id = aws_route53_zone.hosted_zones[each.key].zone_id
}
