locals {
  domains_csv = file("domains.csv")
  domains     = csvdecode(local.domains_csv)
}

# ------------------------------------------------------------------------------------------
# Route 53 registered domains

resource "aws_route53domains_registered_domain" "domains" {
  for_each = { for domain in local.domains : domain.immutable_id => domain }

  domain_name = each.key

  tags = {
    Terraform = true
  }
}
