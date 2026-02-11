# ------------------------------------------------------------------------------------------
# Variables

variable "github_actions_aws_audience" {
  type        = string
  default     = "sts.amazonaws.com"
  description = "The audience value to use in run identity tokens"
}

variable "github_actions_hostname" {
  type        = string
  default     = "token.actions.githubusercontent.com"
  description = "URL of the GitHub OIDC IdP to use with AWS"
}

variable "github_actions_organization_name" {
  type        = string
  default     = "lucascantor"
  description = "The name of the GitHub organization in which GitHub Actions will authenticate with AWS"
}

variable "github_actions_repo_name_aws" {
  type        = string
  default     = "aws"
  description = "The name of a GitHub repo to use with AWS"
}

variable "region" {
  description = "The AWS region into which the resources will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "cloudfront_distribution_zone_id" {
  description = "Static zone ID used for all AWS CloudFront distributions"
  type        = string
  default     = "Z2FDTNDATAQYW2"
}
