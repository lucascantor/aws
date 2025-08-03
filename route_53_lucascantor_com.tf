# ------------------------------------------------------------------------------------------
# lucascantor.com

resource "aws_route53_record" "lucascantor_com__SOA" {
  zone_id = aws_route53_zone.hosted_zones["lucascantor.com"].zone_id
  name    = "lucascantor.com"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["lucascantor.com"].name_servers[2]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "lucascantor_com__NS" {
  zone_id = aws_route53_zone.hosted_zones["lucascantor.com"].zone_id
  name    = "lucascantor.com"
  type    = "NS"
  ttl     = "172800"
  records = [
    "${aws_route53_zone.hosted_zones["lucascantor.com"].name_servers[0]}.",
    "${aws_route53_zone.hosted_zones["lucascantor.com"].name_servers[1]}.",
    "${aws_route53_zone.hosted_zones["lucascantor.com"].name_servers[2]}.",
    "${aws_route53_zone.hosted_zones["lucascantor.com"].name_servers[3]}.",
  ]
}

resource "aws_route53_record" "lucascantor_com__A" {
  zone_id = aws_route53_zone.hosted_zones["lucascantor.com"].zone_id
  name    = "lucascantor.com"
  type    = "A"
  
  alias {
    name                   = aws_cloudfront_distribution.lucascantor_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_lucascantor_com__A" {
  zone_id = aws_route53_zone.hosted_zones["lucascantor.com"].zone_id
  name    = "www.lucascantor.com"
  type    = "A"
  
  alias {
    name                   = aws_cloudfront_distribution.lucascantor_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "blog_lucascantor_com__A" {
  zone_id = aws_route53_zone.hosted_zones["lucascantor.com"].zone_id
  name    = "blog.lucascantor.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.blog_lucascantor_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cdn_lucascantor_com__A" {
  zone_id = aws_route53_zone.hosted_zones["lucascantor.com"].zone_id
  name    = "cdn.lucascantor.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn_lucascantor_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "lucascantor_com__MX" {
  zone_id = aws_route53_zone.hosted_zones["lucascantor.com"].zone_id
  name    = "lucascantor.com"
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 .",
  ]
}

resource "aws_route53_record" "lucascantor_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["lucascantor.com"].zone_id
  name    = "lucascantor.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 -all",
  ]
}

resource "aws_route53_record" "dmarc_lucascantor_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["lucascantor.com"].zone_id
  name    = "_dmarc.lucascantor.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=reject; rua=mailto:dmarc@lucascantor.com,mailto:cantor-d@dmarc.report-uri.com; ruf=mailto:dmarc@lucascantor.com; fo=1; pct=100; adkim=s; aspf=s",
  ]
}

resource "aws_route53_record" "domainkey_lucascantor_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["lucascantor.com"].zone_id
  name    = "*._domainkey.lucascantor.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; p=",
  ]
}
