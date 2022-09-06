# ------------------------------------------------------------------------------------------
# Route 53 registered domains

locals {
  domains_csv = file("route_53_domains.csv")
  domains     = csvdecode(local.domains_csv)
}

resource "aws_route53domains_registered_domain" "domains" {
  for_each = { for domain in local.domains : domain.immutable_id => domain }

  domain_name        = each.key
  admin_privacy      = each.value.admin_privacy == "true" ? true : false
  auto_renew         = each.value.auto_renew == "true" ? true : false
  registrant_privacy = each.value.registrant_privacy == "true" ? true : false
  tech_privacy       = each.value.tech_privacy == "true" ? true : false
  transfer_lock      = each.value.transfer_lock == "true" ? true : false
}

# ------------------------------------------------------------------------------------------
# Route 53 hosted zones

locals {
  hosted_zones_csv = file("route_53_hosted_zones.csv")
  hosted_zones     = csvdecode(local.hosted_zones_csv)
}

resource "aws_route53_zone" "hosted_zones" {
  for_each = { for hosted_zone in local.hosted_zones : hosted_zone.immutable_id => hosted_zone }

  name    = each.key
  comment = var.terraform_warning
}
