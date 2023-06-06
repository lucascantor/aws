# ------------------------------------------------------------------------------------------
# cantor.cloud

resource "aws_route53_record" "cantor_cloud__SOA" {
  zone_id = aws_route53_zone.hosted_zones["cantor.cloud"].zone_id
  name    = "cantor.cloud"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["cantor.cloud"].name_servers[1]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "cantor_cloud__NS" {
  zone_id = aws_route53_zone.hosted_zones["cantor.cloud"].zone_id
  name    = "cantor.cloud"
  type    = "NS"
  ttl     = "172800"
  records = [
    "${aws_route53_zone.hosted_zones["cantor.cloud"].name_servers[0]}.",
    "${aws_route53_zone.hosted_zones["cantor.cloud"].name_servers[1]}.",
    "${aws_route53_zone.hosted_zones["cantor.cloud"].name_servers[2]}.",
    "${aws_route53_zone.hosted_zones["cantor.cloud"].name_servers[3]}.",
  ]
}

resource "aws_route53_record" "cantor_cloud__A" {
  zone_id = aws_route53_zone.hosted_zones["cantor.cloud"].zone_id
  name    = "cantor.cloud"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cantor_cloud.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_cantor_cloud__A" {
  zone_id = aws_route53_zone.hosted_zones["cantor.cloud"].zone_id
  name    = "www.cantor.cloud"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cantor_cloud.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cantor_cloud__MX" {
  zone_id = aws_route53_zone.hosted_zones["cantor.cloud"].zone_id
  name    = "cantor.cloud"
  type    = "MX"
  ttl     = "3600"
  records = [
    "1 SMTP.GOOGLE.COM",
  ]
}

resource "aws_route53_record" "cantor_cloud__TXT" {
  zone_id = aws_route53_zone.hosted_zones["cantor.cloud"].zone_id
  name    = "cantor.cloud"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 include:_spf.google.com include:spf.protection.outlook.com ~all",
    "google-site-verification=uuX66DHR88MjdyQ4UxPoNQyYSazX68cR166T8-vOuX8",
  ]
}

resource "aws_route53_record" "dmarc_cantor_cloud__TXT" {
  zone_id = aws_route53_zone.hosted_zones["cantor.cloud"].zone_id
  name    = "_dmarc.cantor.cloud"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=reject; pct=100; fo=1; adkim=s; aspf=s; rua=mailto:dmarc@cantor.cloud; ruf=mailto:dmarc@cantor.cloud",
  ]
}

resource "aws_route53_record" "google_domainkey_cantor_cloud__TXT" {
  zone_id = aws_route53_zone.hosted_zones["cantor.cloud"].zone_id
  name    = "google._domainkey.cantor.cloud"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCaX6HMcezMI6MnOpByy3PouRWDvwq86Sm+ZxDlZSXewyEoYR/dpEmHsW7vNq3n5kvFWx0I1ZhLInl+pNietrHHb0KE+Q9AXFJfNeV+f+tztS4ZjbpTvsg75mXmbvsuXSL9uTPpg+YoR3+qirQQ7Yhkq7QGDiHOevh84MljuO25MwIDAQAB",
  ]
}

resource "aws_route53_record" "selector1_domainkey_cantor_cloud__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["cantor.cloud"].zone_id
  name    = "selector1._domainkey.cantor.cloud"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "selector1-cantor-cloud._domainkey.cantorcloud.onmicrosoft.com",
  ]
}

resource "aws_route53_record" "selector2_domainkey_cantor_cloud__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["cantor.cloud"].zone_id
  name    = "selector2._domainkey.cantor.cloud"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "selector2-cantor-cloud._domainkey.cantorcloud.onmicrosoft.com",
  ]
}

resource "aws_route53_record" "autodiscover_cantor_cloud__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["cantor.cloud"].zone_id
  name    = "autodiscover.cantor.cloud"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "autodiscover.outlook.com.",
  ]
}

resource "aws_route53_record" "enterpriseenrollment_cantor_cloud__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["cantor.cloud"].zone_id
  name    = "enterpriseenrollment.cantor.cloud"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "enterpriseenrollment.manage.microsoft.com.",
  ]
}

resource "aws_route53_record" "enterpriseregistration_cantor_cloud__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["cantor.cloud"].zone_id
  name    = "enterpriseregistration.cantor.cloud"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "enterpriseregistration.windows.net.",
  ]
}

resource "aws_route53_record" "lyncdiscover_cantor_cloud__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["cantor.cloud"].zone_id
  name    = "lyncdiscover.cantor.cloud"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "webdir.online.lync.com.",
  ]
}

resource "aws_route53_record" "sip_cantor_cloud__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["cantor.cloud"].zone_id
  name    = "sip.cantor.cloud"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "sipdir.online.lync.com.",
  ]
}

resource "aws_route53_record" "sipfederationtls_tcp_cantor_cloud__SRV" {
  zone_id = aws_route53_zone.hosted_zones["cantor.cloud"].zone_id
  name    = "_sipfederationtls._tcp.cantor.cloud"
  type    = "SRV"
  ttl     = "3600"
  records = [
    "100 1 5061 sipfed.online.lync.com.",
  ]
}

resource "aws_route53_record" "sip_tls_cantor_cloud__SRV" {
  zone_id = aws_route53_zone.hosted_zones["cantor.cloud"].zone_id
  name    = "_sip._tls.cantor.cloud"
  type    = "SRV"
  ttl     = "3600"
  records = [
    "100 1 443 sipdir.online.lync.com.",
  ]
}
