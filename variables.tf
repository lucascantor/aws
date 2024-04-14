# ------------------------------------------------------------------------------------------
# Variables

variable "tfc_aws_audience" {
  type        = string
  default     = "aws.workload.identity"
  description = "The audience value to use in run identity tokens"
}

variable "tfc_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE instance to use with AWS"
}

variable "tfc_organization_name" {
  type        = string
  default     = "unitizer"
  description = "The name of the Terraform Cloud organization to use with AWS"
}

variable "tfc_project_name" {
  type        = string
  default     = "Default Project"
  description = "The name of the Terraform Cloud project under which a workspace will be used"
}

variable "tfc_workspace_name" {
  type        = string
  default     = "aws"
  description = "The name of the Terraform Cloud workspace to connect to AWS"
}

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

variable "content_security_policy" {
  description = "The policy directives and their values that CloudFront includes as values for the Content-Security-Policy HTTP response header"
  type        = string
  default     = "default-src 'none'; object-src 'none'; base-uri 'none'; frame-ancestors 'none'; form-action 'none'; connect-src 'self'; media-src 'self'; script-src 'self' 'sha256-fLy5yEG00y7Rwvrfq4J1+3TjE9gbDJ2fhb0Xhlt2iA8=' 'sha256-x7uqmIfkWN6rzmKPSBW2prET6ykmbHpGX0HYPMksA7g='; manifest-src 'self'; frame-src 'self'; img-src 'self' https://cdn.lucascantor.com; style-src 'self' 'sha256-l0uXmF1GYYYZ1FYPD8nS8UqzIwKdCYjHdi6fmVn+7dI=' https://cdn.lucascantor.com https://fonts.googleapis.com https://fonts.gstatic.com; font-src 'self' https://cdn.lucascantor.com https://fonts.googleapis.com https://fonts.gstatic.com"
}
