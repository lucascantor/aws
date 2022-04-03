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
