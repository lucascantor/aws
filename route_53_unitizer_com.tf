# ------------------------------------------------------------------------------------------
# unitizer.com

resource "aws_route53_record" "unitizer_com__SOA" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "unitizer.com"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["unitizer.com"].name_servers[1]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "unitizer_com__NS" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "unitizer.com"
  type    = "NS"
  ttl     = "172800"
  records = [
    "${aws_route53_zone.hosted_zones["unitizer.com"].name_servers[0]}.",
    "${aws_route53_zone.hosted_zones["unitizer.com"].name_servers[1]}.",
    "${aws_route53_zone.hosted_zones["unitizer.com"].name_servers[2]}.",
    "${aws_route53_zone.hosted_zones["unitizer.com"].name_servers[3]}.",
  ]
}

resource "aws_route53_record" "unitizer_com__A" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "unitizer.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.unitizer_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_unitizer_com__A" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "www.unitizer.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.unitizer_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "mta_sts_unitizer_com__A" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "mta-sts.unitizer.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.mta_sts_unitizer_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "unitizer_com__MX" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "unitizer.com"
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 unitizer-com.mail.protection.outlook.com.",
  ]
}

resource "aws_route53_record" "unitizer_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "unitizer.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 include:spf.protection.outlook.com -all",
  ]
}

resource "aws_route53_record" "dmarc_unitizer_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "_dmarc.unitizer.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=reject; rua=mailto:dmarc@unitizer.com,mailto:cantor-d@dmarc.report-uri.com; ruf=mailto:dmarc@unitizer.com; fo=1; pct=100; adkim=s; aspf=s",
  ]
}

resource "aws_route53_record" "selector1_domainkey_unitizer_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "selector1._domainkey.unitizer.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "selector1-unitizer-com._domainkey.unitizer.onmicrosoft.com",
  ]
}

resource "aws_route53_record" "selector2_domainkey_unitizer_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "selector2._domainkey.unitizer.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "selector2-unitizer-com._domainkey.unitizer.onmicrosoft.com",
  ]
}

resource "aws_route53_record" "smtp_tls_unitizer_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "_smtp._tls.unitizer.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=TLSRPTv1; rua=mailto:mta-sts@unitizer.com,mailto:cantor-d@tlsrpt.report-uri.com",
  ]
}

resource "aws_route53_record" "mta_sts_unitizer_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "_mta-sts.unitizer.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=STSv1; id=20240503162008Z;",
  ]
}

resource "aws_route53_record" "autodiscover_unitizer_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "autodiscover.unitizer.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "autodiscover.outlook.com.",
  ]
}

resource "aws_route53_record" "enterpriseenrollment_unitizer_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "enterpriseenrollment.unitizer.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "enterpriseenrollment.manage.microsoft.com.",
  ]
}

resource "aws_route53_record" "enterpriseregistration_unitizer_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "enterpriseregistration.unitizer.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "enterpriseregistration.windows.net.",
  ]
}

resource "aws_route53_record" "lyncdiscover_unitizer_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "lyncdiscover.unitizer.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "webdir.online.lync.com.",
  ]
}

resource "aws_route53_record" "sip_unitizer_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "sip.unitizer.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "sipdir.online.lync.com.",
  ]
}

resource "aws_route53_record" "sipfederationtls_tcp_unitizer_com__SRV" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "_sipfederationtls._tcp.unitizer.com"
  type    = "SRV"
  ttl     = "3600"
  records = [
    "100 1 5061 sipfed.online.lync.com.",
  ]
}

resource "aws_route53_record" "sip_tls_unitizer_com__SRV" {
  zone_id = aws_route53_zone.hosted_zones["unitizer.com"].zone_id
  name    = "_sip._tls.unitizer.com"
  type    = "SRV"
  ttl     = "3600"
  records = [
    "100 1 443 sipdir.online.lync.com.",
  ]
}
