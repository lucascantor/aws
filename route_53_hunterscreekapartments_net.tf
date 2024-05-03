# ------------------------------------------------------------------------------------------
# hunterscreekapartments.net

resource "aws_route53_record" "hunterscreekapartments_net__SOA" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "hunterscreekapartments.net"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["hunterscreekapartments.net"].name_servers[2]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "hunterscreekapartments_net__NS" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "hunterscreekapartments.net"
  type    = "NS"
  ttl     = "172800"
  records = [
    "${aws_route53_zone.hosted_zones["hunterscreekapartments.net"].name_servers[0]}.",
    "${aws_route53_zone.hosted_zones["hunterscreekapartments.net"].name_servers[1]}.",
    "${aws_route53_zone.hosted_zones["hunterscreekapartments.net"].name_servers[2]}.",
    "${aws_route53_zone.hosted_zones["hunterscreekapartments.net"].name_servers[3]}.",
  ]
}

resource "aws_route53_record" "hunterscreekapartments_net__A" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "hunterscreekapartments.net"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.hunterscreekapartments_net.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_hunterscreekapartments_net__A" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "www.hunterscreekapartments.net"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.hunterscreekapartments_net.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "beta_hunterscreekapartments_net__A" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "beta.hunterscreekapartments.net"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.hunterscreekapartments_net.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "mta_sts_hunterscreekapartments_net__A" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "mta-sts.hunterscreekapartments.net"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.mta_sts_hunterscreekapartments_net.domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "hunterscreekapartments_net__MX" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "hunterscreekapartments.net"
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 hunterscreekapartments-net.mail.protection.outlook.com.",
  ]
}

resource "aws_route53_record" "hunterscreekapartments_net__TXT" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "hunterscreekapartments.net"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 include:spf.protection.outlook.com -all",
    "stripe-verification=0593cdce716640d7656497ee3641ff5735b773cc17690062a79fe53552d67dd5",
  ]
}

resource "aws_route53_record" "dmarc_hunterscreekapartments_net__TXT" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "_dmarc.hunterscreekapartments.net"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=reject; rua=mailto:dmarc@hunterscreekapartments.net,mailto:cantor-d@dmarc.report-uri.com; ruf=mailto:dmarc@hunterscreekapartments.net; fo=1; pct=100; adkim=s; aspf=s",
  ]
}

resource "aws_route53_record" "selector1_domainkey_hunterscreekapartments_net__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "selector1._domainkey.hunterscreekapartments.net"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "selector1-hunterscreekapartments-net._domainkey.unitizer.onmicrosoft.com",
  ]
}

resource "aws_route53_record" "selector2_domainkey_hunterscreekapartments_net__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "selector2._domainkey.hunterscreekapartments.net"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "selector2-hunterscreekapartments-net._domainkey.unitizer.onmicrosoft.com",
  ]
}

resource "aws_route53_record" "stripe_2d7ru32ll75grkmjt2etaszqx72vapvw_domainkey_hunterscreekapartments_net__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "2d7ru32ll75grkmjt2etaszqx72vapvw._domainkey.hunterscreekapartments.net"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "2d7ru32ll75grkmjt2etaszqx72vapvw.dkim.custom-email-domain.stripe.com.",
  ]
}

resource "aws_route53_record" "stripe_elheafcq63jgkqkyrpis56uhifw4smyr_domainkey_hunterscreekapartments_net__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "elheafcq63jgkqkyrpis56uhifw4smyr._domainkey.hunterscreekapartments.net"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "elheafcq63jgkqkyrpis56uhifw4smyr.dkim.custom-email-domain.stripe.com.",
  ]
}

resource "aws_route53_record" "stripe_fbspeyryizd7lery5jxvbooeyx4pogcr_domainkey_hunterscreekapartments_net__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "fbspeyryizd7lery5jxvbooeyx4pogcr._domainkey.hunterscreekapartments.net"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "fbspeyryizd7lery5jxvbooeyx4pogcr.dkim.custom-email-domain.stripe.com.",
  ]
}

resource "aws_route53_record" "stripe_iskmt5qkv4vnfqfx6huoqm242fmxdsiw_domainkey_hunterscreekapartments_net__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "iskmt5qkv4vnfqfx6huoqm242fmxdsiw._domainkey.hunterscreekapartments.net"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "iskmt5qkv4vnfqfx6huoqm242fmxdsiw.dkim.custom-email-domain.stripe.com.",
  ]
}

resource "aws_route53_record" "stripe_kogk4llrdh6dz66rnntq3hdsdzwt3d3w_domainkey_hunterscreekapartments_net__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "kogk4llrdh6dz66rnntq3hdsdzwt3d3w._domainkey.hunterscreekapartments.net"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "kogk4llrdh6dz66rnntq3hdsdzwt3d3w.dkim.custom-email-domain.stripe.com.",
  ]
}

resource "aws_route53_record" "stripe_x27kimkgkei3tfaxbpwaxbbtry4ysxzf_domainkey_hunterscreekapartments_net__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "x27kimkgkei3tfaxbpwaxbbtry4ysxzf._domainkey.hunterscreekapartments.net"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "x27kimkgkei3tfaxbpwaxbbtry4ysxzf.dkim.custom-email-domain.stripe.com.",
  ]
}

resource "aws_route53_record" "smtp_tls_hunterscreekapartments_net__TXT" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "_smtp._tls.hunterscreekapartments.net"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=TLSRPTv1; rua=mailto:mta-sts@hunterscreekapartments.net,mailto:cantor-d@tlsrpt.report-uri.com",
  ]
}

resource "time_static" "mta_sts_hunterscreekapartments_net__TXT" {
  triggers = {
    # update when mta-sts.txt file content changes
    version = filemd5("websites/mta-sts.hunterscreekapartments.net/.well-known/mta-sts.txt")
  }
}

resource "aws_route53_record" "mta_sts_hunterscreekapartments_net__TXT" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "_mta-sts.hunterscreekapartments.net"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=STSv1; id=${time_static.mta_sts_hunterscreekapartments_net__TXT.unix};",
  ]
}

resource "aws_route53_record" "autodiscover_hunterscreekapartments_net__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "autodiscover.hunterscreekapartments.net"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "autodiscover.outlook.com.",
  ]
}

resource "aws_route53_record" "bounce_hunterscreekapartments_net__CNAME" {
  zone_id = aws_route53_zone.hosted_zones["hunterscreekapartments.net"].zone_id
  name    = "bounce.hunterscreekapartments.net"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "custom-email-domain.stripe.com.",
  ]
}
