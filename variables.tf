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
