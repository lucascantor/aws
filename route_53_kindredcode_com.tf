# ------------------------------------------------------------------------------------------
# kindredcode.com

resource "aws_route53_record" "kindredcode_com__SOA" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "kindredcode.com"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["kindredcode.com"].name_servers[0]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "kindredcode_com__NS" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "kindredcode.com"
  type    = "NS"
  ttl     = "172800"
  records = [
    "${aws_route53_zone.hosted_zones["kindredcode.com"].name_servers[0]}.",
    "${aws_route53_zone.hosted_zones["kindredcode.com"].name_servers[1]}.",
    "${aws_route53_zone.hosted_zones["kindredcode.com"].name_servers[2]}.",
    "${aws_route53_zone.hosted_zones["kindredcode.com"].name_servers[3]}.",
  ]
}

resource "aws_route53_record" "kindredcode_com__A" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "kindredcode.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.kindredcode_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_kindredcode_com__A" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "www.kindredcode.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.kindredcode_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "kindredcode_com__MX" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "kindredcode.com"
  type    = "MX"
  ttl     = "3600"
  records = [
    "1 SMTP.GOOGLE.COM",
  ]
}

resource "aws_route53_record" "kindredcode_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "kindredcode.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 include:_spf.google.com include:spf.protection.outlook.com ~all",
    "google-site-verification=iCA61zpmcK-WMakf4kxbB4SCE2r0P1knduvt3skSHwY",
  ]
}

resource "aws_route53_record" "dmarc_kindredcode_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "_dmarc.kindredcode.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=none; pct=100; fo=1; adkim=s; aspf=s; rua=mailto:dmarc@kindredcode.com; ruf=mailto:dmarc@kindredcode.com",
  ]
}

resource "aws_route53_record" "google_domainkey_kindredcode_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "google._domainkey.kindredcode.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnoc1Ne5qL2aM3ezG8MDb5WBaX84aGQwtDUGdL/lcNXi8PnM3Ok9xJVuVMA5L1zBJvAgtz/djU9yliqmd8mhTApwPfTxDfVDj2kbw0wcsF+BRhDxp2tTHanfrJAu/OP6fQYfggto0KTVzVrwzj12fd+oqH0wrqjjxgi3q+qSB0q8c9SDK7cxamJlXITtTegv8PA3XHzbW79JEKkL2RtTY1OeM2fWoAtO1IXOeDGkKQ4b4kX2RuC+X94AdwdAWEaei54s+024h47l7EAWMs8FdplD4zN6+H+0f/CdKKDiz3M0FDFPUEwUmed6kIsgAHy/xASucGO08diG76mjA079mPwIDAQAB",
  ]
}

resource "aws_route53_record" "github_challenge_kindredcode_kindredcode_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "_github-challenge-kindredcode.kindredcode.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "6bc9fd3749",
  ]
}

resource "aws_route53_record" "selector1_domainkey_kindredcode_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "selector1._domainkey.kindredcode.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "selector1-kindredcode-com._domainkey.cantorcloud.onmicrosoft.com",
  ]
}

resource "aws_route53_record" "selector2_domainkey_kindredcode_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "selector2._domainkey.kindredcode.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "selector2-kindredcode-com._domainkey.cantorcloud.onmicrosoft.com",
  ]
}

resource "aws_route53_record" "autodiscover_kindredcode_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "autodiscover.kindredcode.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "autodiscover.outlook.com.",
  ]
}

resource "aws_route53_record" "enterpriseenrollment_kindredcode_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "enterpriseenrollment.kindredcode.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "enterpriseenrollment.manage.microsoft.com.",
  ]
}

resource "aws_route53_record" "enterpriseregistration_kindredcode_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "enterpriseregistration.kindredcode.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "enterpriseregistration.windows.net.",
  ]
}

resource "aws_route53_record" "lyncdiscover_kindredcode_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "lyncdiscover.kindredcode.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "webdir.online.lync.com.",
  ]
}

resource "aws_route53_record" "sip_kindredcode_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "sip.kindredcode.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "sipdir.online.lync.com.",
  ]
}

resource "aws_route53_record" "sipfederationtls_tcp_kindredcode_com__SRV" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "_sipfederationtls._tcp.kindredcode.com"
  type    = "SRV"
  ttl     = "3600"
  records = [
    "100 1 5061 sipfed.online.lync.com.",
  ]
}

resource "aws_route53_record" "sip_tls_kindredcode_com__SRV" {
  zone_id = aws_route53_zone.hosted_zones["kindredcode.com"].zone_id
  name    = "_sip._tls.kindredcode.com"
  type    = "SRV"
  ttl     = "3600"
  records = [
    "100 1 443 sipdir.online.lync.com.",
  ]
}
