# ------------------------------------------------------------------------------------------
# centerpointwest.com

resource "aws_route53_record" "centerpointwest_com__SOA" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "centerpointwest.com"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["centerpointwest.com"].name_servers[1]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "centerpointwest_com__NS" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "centerpointwest.com"
  type    = "NS"
  ttl     = "172800"
  records = [
    "${aws_route53_zone.hosted_zones["centerpointwest.com"].name_servers[0]}.",
    "${aws_route53_zone.hosted_zones["centerpointwest.com"].name_servers[1]}.",
    "${aws_route53_zone.hosted_zones["centerpointwest.com"].name_servers[2]}.",
    "${aws_route53_zone.hosted_zones["centerpointwest.com"].name_servers[3]}.",
  ]
}

resource "aws_route53_record" "centerpointwest_com__A" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "centerpointwest.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.centerpointwest_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_centerpointwest_com__A" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "www.centerpointwest.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.centerpointwest_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "beta_centerpointwest_com__A" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "beta.centerpointwest.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.centerpointwest_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "mta_sts_centerpointwest_com__A" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "mta-sts.centerpointwest.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.mta_sts_centerpointwest_com.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "centerpointwest_com__MX" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "centerpointwest.com"
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 centerpointwest-com.mail.protection.outlook.com.",
  ]
}

resource "aws_route53_record" "centerpointwest_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "centerpointwest.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 include:spf.protection.outlook.com -all",
    "stripe-verification=a4e78b0e912bd0b2e726a7a531f15e8417dcf7652303091c49ccc7be03781b86",
  ]
}

resource "aws_route53_record" "dmarc_centerpointwest_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "_dmarc.centerpointwest.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=reject; rua=mailto:dmarc@centerpointwest.com,mailto:cantor-d@dmarc.report-uri.com; ruf=mailto:dmarc@centerpointwest.com; fo=1; pct=100; adkim=s; aspf=s",
  ]
}

resource "aws_route53_record" "selector1_domainkey_centerpointwest_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "selector1._domainkey.centerpointwest.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "selector1-centerpointwest-com._domainkey.unitizer.onmicrosoft.com",
  ]
}

resource "aws_route53_record" "selector2_domainkey_centerpointwest_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "selector2._domainkey.centerpointwest.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "selector2-centerpointwest-com._domainkey.unitizer.onmicrosoft.com",
  ]
}

resource "aws_route53_record" "ahsafzcelf6xlmvt24riqx4o7hxnysuv_domainkey_centerpointwest_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "ahsafzcelf6xlmvt24riqx4o7hxnysuv._domainkey.centerpointwest.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "ahsafzcelf6xlmvt24riqx4o7hxnysuv.dkim.custom-email-domain.stripe.com.",
  ]
}

resource "aws_route53_record" "beirjkq423inr6bbj3fgdwtkumq5ihvh_domainkey_centerpointwest_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "beirjkq423inr6bbj3fgdwtkumq5ihvh._domainkey.centerpointwest.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "beirjkq423inr6bbj3fgdwtkumq5ihvh.dkim.custom-email-domain.stripe.com.",
  ]
}

resource "aws_route53_record" "fbfano7atlblcgkdcmitm7wdb73qzybn_domainkey_centerpointwest_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "fbfano7atlblcgkdcmitm7wdb73qzybn._domainkey.centerpointwest.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "fbfano7atlblcgkdcmitm7wdb73qzybn.dkim.custom-email-domain.stripe.com.",
  ]
}

resource "aws_route53_record" "puxvctum2tdhsvfnuvshgj36etumm5bu_domainkey_centerpointwest_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "puxvctum2tdhsvfnuvshgj36etumm5bu._domainkey.centerpointwest.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "puxvctum2tdhsvfnuvshgj36etumm5bu.dkim.custom-email-domain.stripe.com.",
  ]
}

resource "aws_route53_record" "rki5cu3pn3254xyj2pzwsglgkxbumsnm_domainkey_centerpointwest_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "rki5cu3pn3254xyj2pzwsglgkxbumsnm._domainkey.centerpointwest.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "rki5cu3pn3254xyj2pzwsglgkxbumsnm.dkim.custom-email-domain.stripe.com.",
  ]
}

resource "aws_route53_record" "ypairuwclldey5b6yvwnzdzwadvl7jqg_domainkey_centerpointwest_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "ypairuwclldey5b6yvwnzdzwadvl7jqg._domainkey.centerpointwest.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "ypairuwclldey5b6yvwnzdzwadvl7jqg.dkim.custom-email-domain.stripe.com.",
  ]
}

resource "aws_route53_record" "smtp_tls_centerpointwest_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "_smtp._tls.centerpointwest.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=TLSRPTv1; rua=mailto:mta-sts@centerpointwest.com,mailto:cantor-d@tlsrpt.report-uri.com",
  ]
}

resource "aws_route53_record" "mta_sts_centerpointwest_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "_mta-sts.centerpointwest.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=STSv1; id=20240503173002Z;",
  ]
}

resource "aws_route53_record" "autodiscover_centerpointwest_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "autodiscover.centerpointwest.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "autodiscover.outlook.com.",
  ]
}

resource "aws_route53_record" "bounce_centerpointwest_com__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["centerpointwest.com"].zone_id
  name    = "bounce.centerpointwest.com"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "custom-email-domain.stripe.com.",
  ]
}
