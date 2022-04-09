# ------------------------------------------------------------------------------------------
# Route 53 registered domains

locals {
  domains_csv = file("domains.csv")
  domains     = csvdecode(local.domains_csv)
}

resource "aws_route53domains_registered_domain" "domains" {
  for_each = { for domain in local.domains : domain.immutable_id => domain }

  domain_name        = each.key
  admin_privacy      = true
  auto_renew         = true
  registrant_privacy = true
  tech_privacy       = true
  transfer_lock      = true
}

# ------------------------------------------------------------------------------------------
# Route 53 hosted zones

locals {
  hosted_zones_csv = file("hosted_zones.csv")
  hosted_zones     = csvdecode(local.hosted_zones_csv)
}

resource "aws_route53_zone" "hosted_zones" {
  for_each = { for hosted_zone in local.hosted_zones : hosted_zone.immutable_id => hosted_zone }

  name    = each.key
  comment = var.terraform_warning
}

# ------------------------------------------------------------------------------------------
# lizzythepooch.com

resource "aws_route53_record" "lizzythepooch_com__SOA" {
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
  name    = "lizzythepooch.com"
  type    = "SOA"
  ttl     = "900"
  records = [
    "${aws_route53_zone.hosted_zones["lizzythepooch.com"].name_servers[1]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "lizzythepooch_com__NS" {
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
  name    = "lizzythepooch.com"
  type    = "NS"
  ttl     = "172800"
  records = [
    aws_route53_zone.hosted_zones["lizzythepooch.com"].name_servers[0],
    aws_route53_zone.hosted_zones["lizzythepooch.com"].name_servers[1],
    aws_route53_zone.hosted_zones["lizzythepooch.com"].name_servers[2],
    aws_route53_zone.hosted_zones["lizzythepooch.com"].name_servers[3],
  ]
}

resource "aws_route53_record" "lizzythepooch_com__A" {
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
  name    = "lizzythepooch.com"
  type    = "A"

  alias {
    name                   = var.cloudfront_distribution_domain_names["lizzythepooch.com"]
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_lizzythepooch_com__A" {
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
  name    = "www.lizzythepooch.com"
  type    = "A"

  alias {
    name                   = var.cloudfront_distribution_domain_names["lizzythepooch.com"]
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "lizzythepooch_com__MX" {
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
  name    = "lizzythepooch.com"
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 .",
  ]
}

resource "aws_route53_record" "lizzythepooch_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
  name    = "lizzythepooch.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 -all",
  ]
}

resource "aws_route53_record" "dmarc_lizzythepooch_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
  name    = "_dmarc.lizzythepooch.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1;p=reject;sp=reject;adkim=s;aspf=s;fo=1;rua=mailto:dmarc@lizzythepooch.com,mailto:dmarc@lizzythepooch.com",
  ]
}

resource "aws_route53_record" "domainkey_lizzythepooch_com__TXT" {
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
  name    = "*._domainkey.lizzythepooch.com"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; p=",
  ]
}

resource "aws_route53_record" "lizzythepooch_com__cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.lizzythepooch_com.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if substr(dvo.domain_name, 0, 2) != "*."
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 300
  type    = each.value.type
  zone_id = aws_route53_zone.hosted_zones["lizzythepooch.com"].zone_id
}
