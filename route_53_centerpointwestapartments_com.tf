# ------------------------------------------------------------------------------------------
# centerpointwestapartments.com

resource "aws_route53_record" "centerpointwestapartments_com__SOA" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwestapartments.com"].zone_id
  name    = "centerpointwestapartments.com"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["centerpointwestapartments.com"].name_servers[2]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "centerpointwestapartments_com__NS" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwestapartments.com"].zone_id
  name    = "centerpointwestapartments.com"
  type    = "NS"
  ttl     = "172800"
  records = [
    "${aws_route53_zone.hosted_zones["centerpointwestapartments.com"].name_servers[0]}.",
    "${aws_route53_zone.hosted_zones["centerpointwestapartments.com"].name_servers[1]}.",
    "${aws_route53_zone.hosted_zones["centerpointwestapartments.com"].name_servers[2]}.",
    "${aws_route53_zone.hosted_zones["centerpointwestapartments.com"].name_servers[3]}.",
  ]
}

resource "aws_route53_record" "centerpointwestapartments_com__A" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwestapartments.com"].zone_id
  name    = "centerpointwestapartments.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.centerpointwest_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_centerpointwestapartments_com__A" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwestapartments.com"].zone_id
  name    = "www.centerpointwestapartments.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.centerpointwest_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "mta_sts_centerpointwestapartments_com__A" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwestapartments.com"].zone_id
  name    = "mta-sts.centerpointwestapartments.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.mta_sts_centerpointwestapartments_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "centerpointwestapartments_com__MX" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwestapartments.com"].zone_id
  name    = "centerpointwestapartments.com"
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 centerpointwestapartments-com.mail.protection.outlook.com.",
  ]
}

resource "aws_route53_record" "centerpointwestapartments_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwestapartments.com"].zone_id
  name    = "centerpointwestapartments.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 include:spf.protection.outlook.com -all",
  ]
}

resource "aws_route53_record" "dmarc_centerpointwestapartments_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwestapartments.com"].zone_id
  name    = "_dmarc.centerpointwestapartments.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=reject; rua=mailto:dmarc@centerpointwestapartments.com,mailto:cantor-d@dmarc.report-uri.com; ruf=mailto:dmarc@centerpointwestapartments.com; fo=1; pct=100; adkim=s; aspf=s",
  ]
}

resource "aws_route53_record" "selector1_domainkey_centerpointwestapartments_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwestapartments.com"].zone_id
  name    = "selector1._domainkey.centerpointwestapartments.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "selector1-centerpointwestapartments-com._domainkey.unitizer.onmicrosoft.com",
  ]
}

resource "aws_route53_record" "selector2_domainkey_centerpointwestapartments_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwestapartments.com"].zone_id
  name    = "selector2._domainkey.centerpointwestapartments.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "selector2-centerpointwestapartments-com._domainkey.unitizer.onmicrosoft.com",
  ]
}

resource "aws_route53_record" "smtp_tls_centerpointwestapartments_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwestapartments.com"].zone_id
  name    = "_smtp._tls.centerpointwestapartments.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=TLSRPTv1; rua=mailto:mta-sts@centerpointwestapartments.com,mailto:cantor-d@tlsrpt.report-uri.com",
  ]
}

resource "time_static" "mta_sts_centerpointwestapartments_com__TXT" {
  triggers = {
    # update when mta-sts.txt file content changes
    version = filemd5("websites/mta-sts.centerpointwestapartments.com/.well-known/mta-sts.txt")
  }
}

resource "aws_route53_record" "mta_sts_centerpointwestapartments_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwestapartments.com"].zone_id
  name    = "_mta-sts.centerpointwestapartments.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=STSv1; id=${time_static.mta_sts_centerpointwestapartments_com__TXT.unix};",
  ]
}

resource "aws_route53_record" "autodiscover_centerpointwestapartments_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwestapartments.com"].zone_id
  name    = "autodiscover.centerpointwestapartments.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "autodiscover.outlook.com.",
  ]
}
