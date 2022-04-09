# ------------------------------------------------------------------------------------------
# lizzythepooch.com

resource "aws_acm_certificate" "lizzythepooch_com" {
  domain_name = "lizzythepooch.com"
  subject_alternative_names = [
    "*.lizzythepooch.com",
  ]
  validation_method = "DNS"
}
