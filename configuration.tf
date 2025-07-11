# ------------------------------------------------------------------------------------------
# Terraform provider configuration

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.2.0"
    }
  }
  cloud {
    organization = "unitizer"

    workspaces {
      name = "aws"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Terraform = true
    }
  }
}
