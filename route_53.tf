locals {
  domains_csv = file("domains.csv")
  domains     = csvdecode(local.domains_csv)
}

# ------------------------------------------------------------------------------------------
# Route 53 registered domains

resource "aws_route53domains_registered_domain" "domains" {
  for_each = { for domain in local.domains : domain.immutable_id => domain }

  domain_name   = each.key
  admin_privacy = true
  auto_renew    = true
  admin_contact {
    address_line_1    = "83 Arlington Ave"
    city              = "Kensington"
    contact_type      = "PERSON"
    country_code      = "US"
    email             = "lucascantor@gmail.com"
    first_name        = "Lucas"
    last_name         = "Cantor"
    organization_name = ""
    phone_number      = "+1.6102029708"
    state             = "CA"
    zip_code          = "94707"
  }
  registrant_contact {
    address_line_1    = "83 Arlington Ave"
    city              = "Kensington"
    contact_type      = "PERSON"
    country_code      = "US"
    email             = "lucascantor@gmail.com"
    first_name        = "Lucas"
    last_name         = "Cantor"
    organization_name = ""
    phone_number      = "+1.6102029708"
    state             = "CA"
    zip_code          = "94707"
  }
  registrant_privacy = true
  tech_contact {
    address_line_1    = "83 Arlington Ave"
    city              = "Kensington"
    contact_type      = "PERSON"
    country_code      = "US"
    email             = "lucascantor@gmail.com"
    first_name        = "Lucas"
    last_name         = "Cantor"
    organization_name = ""
    phone_number      = "+1.6102029708"
    state             = "CA"
    zip_code          = "94707"
  }
  tech_privacy  = true
  transfer_lock = true

  tags = {
    Terraform = true
  }
}
