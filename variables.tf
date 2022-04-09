# ------------------------------------------------------------------------------------------
# Variables defined in Terraform Cloud

variable "access_key" {
  description = "Access key ID for Terraform IAM user with full admin privileges"
  type        = string
}

variable "secret_key" {
  description = "Secret key for Terraform IAM user with full admin privileges"
  type        = string
  sensitive   = true
}

# ------------------------------------------------------------------------------------------
# Variables

variable "region" {
  description = "The AWS region into which the resources will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "terraform_warning" {
  description = "Warning to configure on resources reminding not to edit them manually"
  type        = string
  default     = "DO NOT EDIT - Managed by Terraform"
}

variable "cloudfront_distribution_zone_id" {
  description = "Static zone ID used for all AWS CloudFront distributions"
  type        = string
  default     = "Z2FDTNDATAQYW2"
}

variable "cloudfront_distribution_domain_names" {
  description = "map of existing CloudFront distribution domain names, to use temporarily during Terraform import"
  type        = map(string)
  default = {
    "cantor.cloud"               = "d1zk2ijj4szow2.cloudfront.net"
    "cdn.lucascantor.com"        = "d1tj1q9mar2m0x.cloudfront.net"
    "centerpointwest.com"        = "d1no6tsu3mphe9.cloudfront.net"
    "francesca-and-lucas.com"    = "d3k1gnsujs6upe.cloudfront.net"
    "hunterscreekapartments.net" = "d3tvscov8gyjjc.cloudfront.net"
    "kindredcode.com"            = "d2sepyl7m5lz49.cloudfront.net"
    "lizzythepooch.com"          = "d13xp8qn1l724e.cloudfront.net"
    "lucascantor.com"            = "d33m8g90iqvky8.cloudfront.net"
    "blog.lucascantor.com"       = "d2kwu0a222e6pc.cloudfront.net"
    "nathanielsigal.com"         = "d1x3378f9frm8g.cloudfront.net"
    "ronaldcantor.com"           = "dhncpcpbkm1q0.cloudfront.net"
    "unitizer.com"               = "d2g072sourj6ej.cloudfront.net"
    "williamsigal.com"           = "d1qzb2dpyrtdg0.cloudfront.net"
  }
}
