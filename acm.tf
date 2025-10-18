# ------------------------------------------------------------------------------------------
# francesca-and-lucas.com

resource "aws_acm_certificate" "francesca_and_lucas_com" {
  domain_name = "francesca-and-lucas.com"
  subject_alternative_names = [
    "*.francesca-and-lucas.com",
  ]
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "francesca_and_lucas_com" {
  certificate_arn         = aws_acm_certificate.francesca_and_lucas_com.arn
  validation_record_fqdns = [for record in aws_route53_record.francesca_and_lucas_com__cert_validation : record.fqdn]
}

resource "aws_route53_record" "francesca_and_lucas_com__cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.francesca_and_lucas_com.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if substr(dvo.domain_name, 0, 2) != "*."
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 300
  type    = each.value.type
  zone_id = aws_route53_zone.hosted_zones[each.key].zone_id
}

# ------------------------------------------------------------------------------------------
# lizzythepooch.com

resource "aws_acm_certificate" "lizzythepooch_com" {
  domain_name = "lizzythepooch.com"
  subject_alternative_names = [
    "*.lizzythepooch.com",
  ]
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "lizzythepooch_com" {
  certificate_arn         = aws_acm_certificate.lizzythepooch_com.arn
  validation_record_fqdns = [for record in aws_route53_record.lizzythepooch_com__cert_validation : record.fqdn]
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
  zone_id = aws_route53_zone.hosted_zones[each.key].zone_id
}

# ------------------------------------------------------------------------------------------
# blakesigal.com

resource "aws_acm_certificate" "blakesigal_com" {
  domain_name = "blakesigal.com"
  subject_alternative_names = [
    "*.blakesigal.com",
  ]
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "blakesigal_com" {
  certificate_arn         = aws_acm_certificate.blakesigal_com.arn
  validation_record_fqdns = [for record in aws_route53_record.blakesigal_com__cert_validation : record.fqdn]
}

resource "aws_route53_record" "blakesigal_com__cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.blakesigal_com.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if substr(dvo.domain_name, 0, 2) != "*."
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 300
  type    = each.value.type
  zone_id = aws_route53_zone.hosted_zones[each.key].zone_id
}

# ------------------------------------------------------------------------------------------
# nathanielsigal.com

resource "aws_acm_certificate" "nathanielsigal_com" {
  domain_name = "nathanielsigal.com"
  subject_alternative_names = [
    "*.nathanielsigal.com",
    "natesigal.com",
    "*.natesigal.com",
  ]
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "nathanielsigal_com" {
  certificate_arn         = aws_acm_certificate.nathanielsigal_com.arn
  validation_record_fqdns = [for record in aws_route53_record.nathanielsigal_com__cert_validation : record.fqdn]
}

resource "aws_route53_record" "nathanielsigal_com__cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.nathanielsigal_com.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if substr(dvo.domain_name, 0, 2) != "*."
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 300
  type    = each.value.type
  zone_id = aws_route53_zone.hosted_zones[each.key].zone_id
}

# ------------------------------------------------------------------------------------------
# williamsigal.com

resource "aws_acm_certificate" "williamsigal_com" {
  domain_name = "williamsigal.com"
  subject_alternative_names = [
    "*.williamsigal.com",
    "willsigal.com",
    "*.willsigal.com",
  ]
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "williamsigal_com" {
  certificate_arn         = aws_acm_certificate.williamsigal_com.arn
  validation_record_fqdns = [for record in aws_route53_record.williamsigal_com__cert_validation : record.fqdn]
}

resource "aws_route53_record" "williamsigal_com__cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.williamsigal_com.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if substr(dvo.domain_name, 0, 2) != "*."
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 300
  type    = each.value.type
  zone_id = aws_route53_zone.hosted_zones[each.key].zone_id
}

# ------------------------------------------------------------------------------------------
# ronaldcantor.com

resource "aws_acm_certificate" "ronaldcantor_com" {
  domain_name = "ronaldcantor.com"
  subject_alternative_names = [
    "*.ronaldcantor.com",
  ]
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "ronaldcantor_com" {
  certificate_arn         = aws_acm_certificate.ronaldcantor_com.arn
  validation_record_fqdns = [for record in aws_route53_record.ronaldcantor_com__cert_validation : record.fqdn]
}

resource "aws_route53_record" "ronaldcantor_com__cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.ronaldcantor_com.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if substr(dvo.domain_name, 0, 2) != "*."
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 300
  type    = each.value.type
  zone_id = aws_route53_zone.hosted_zones[each.key].zone_id
}

# ------------------------------------------------------------------------------------------
# kindredcode.com

resource "aws_acm_certificate" "kindredcode_com" {
  domain_name = "kindredcode.com"
  subject_alternative_names = [
    "*.kindredcode.com",
  ]
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "kindredcode_com" {
  certificate_arn         = aws_acm_certificate.kindredcode_com.arn
  validation_record_fqdns = [for record in aws_route53_record.kindredcode_com__cert_validation : record.fqdn]
}

resource "aws_route53_record" "kindredcode_com__cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.kindredcode_com.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if substr(dvo.domain_name, 0, 2) != "*."
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 300
  type    = each.value.type
  zone_id = aws_route53_zone.hosted_zones[each.key].zone_id
}

# ------------------------------------------------------------------------------------------
# centerpointwest.com

resource "aws_acm_certificate" "centerpointwest_com" {
  domain_name = "centerpointwest.com"
  subject_alternative_names = [
    "*.centerpointwest.com",
    "centerpointwestapartments.com",
    "*.centerpointwestapartments.com",
  ]
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "centerpointwest_com" {
  certificate_arn         = aws_acm_certificate.centerpointwest_com.arn
  validation_record_fqdns = [for record in aws_route53_record.centerpointwest_com__cert_validation : record.fqdn]
}

resource "aws_route53_record" "centerpointwest_com__cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.centerpointwest_com.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if substr(dvo.domain_name, 0, 2) != "*."
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 300
  type    = each.value.type
  zone_id = aws_route53_zone.hosted_zones[each.key].zone_id
}

# ------------------------------------------------------------------------------------------
# hunterscreekapartments.net

resource "aws_acm_certificate" "hunterscreekapartments_net" {
  domain_name = "hunterscreekapartments.net"
  subject_alternative_names = [
    "*.hunterscreekapartments.net",
  ]
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "hunterscreekapartments_net" {
  certificate_arn         = aws_acm_certificate.hunterscreekapartments_net.arn
  validation_record_fqdns = [for record in aws_route53_record.hunterscreekapartments_net__cert_validation : record.fqdn]
}

resource "aws_route53_record" "hunterscreekapartments_net__cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.hunterscreekapartments_net.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if substr(dvo.domain_name, 0, 2) != "*."
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 300
  type    = each.value.type
  zone_id = aws_route53_zone.hosted_zones[each.key].zone_id
}

# ------------------------------------------------------------------------------------------
# lucascantor.com

resource "aws_acm_certificate" "lucascantor_com" {
  domain_name = "lucascantor.com"
  subject_alternative_names = [
    "*.lucascantor.com",
  ]
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "lucascantor_com" {
  certificate_arn         = aws_acm_certificate.lucascantor_com.arn
  validation_record_fqdns = [for record in aws_route53_record.lucascantor_com__cert_validation : record.fqdn]
}

resource "aws_route53_record" "lucascantor_com__cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.lucascantor_com.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if substr(dvo.domain_name, 0, 2) != "*."
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 300
  type    = each.value.type
  zone_id = aws_route53_zone.hosted_zones[each.key].zone_id
}

# ------------------------------------------------------------------------------------------
# serenesolutions.nl

resource "aws_acm_certificate" "serenesolutions_nl" {
  domain_name = "serenesolutions.nl"
  subject_alternative_names = [
    "*.serenesolutions.nl",
  ]
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "serenesolutions_nl" {
  certificate_arn         = aws_acm_certificate.serenesolutions_nl.arn
  validation_record_fqdns = [for record in aws_route53_record.serenesolutions_nl__cert_validation : record.fqdn]
}

resource "aws_route53_record" "serenesolutions_nl__cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.serenesolutions_nl.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if substr(dvo.domain_name, 0, 2) != "*."
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 300
  type    = each.value.type
  zone_id = aws_route53_zone.hosted_zones[each.key].zone_id
}

# ------------------------------------------------------------------------------------------
# unitizer.com

resource "aws_acm_certificate" "unitizer_com" {
  domain_name = "unitizer.com"
  subject_alternative_names = [
    "*.unitizer.com",
  ]
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "unitizer_com" {
  certificate_arn         = aws_acm_certificate.unitizer_com.arn
  validation_record_fqdns = [for record in aws_route53_record.unitizer_com__cert_validation : record.fqdn]
}

resource "aws_route53_record" "unitizer_com__cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.unitizer_com.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if substr(dvo.domain_name, 0, 2) != "*."
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 300
  type    = each.value.type
  zone_id = aws_route53_zone.hosted_zones[each.key].zone_id
}

# ------------------------------------------------------------------------------------------
# cantor.cloud

resource "aws_acm_certificate" "cantor_cloud" {
  domain_name = "cantor.cloud"
  subject_alternative_names = [
    "*.cantor.cloud",
  ]
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "cantor_cloud" {
  certificate_arn         = aws_acm_certificate.cantor_cloud.arn
  validation_record_fqdns = [for record in aws_route53_record.cantor_cloud__cert_validation : record.fqdn]
}

resource "aws_route53_record" "cantor_cloud__cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cantor_cloud.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if substr(dvo.domain_name, 0, 2) != "*."
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 300
  type    = each.value.type
  zone_id = aws_route53_zone.hosted_zones[each.key].zone_id
}
