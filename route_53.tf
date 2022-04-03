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

  tags = {
    Terraform = true
  }
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

  tags = {
    Terraform = true
  }
}
