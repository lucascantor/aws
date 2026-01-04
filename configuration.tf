# ------------------------------------------------------------------------------------------
# Terraform provider configuration

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6"
    }
  }
  backend "s3" {
    region       = "us-east-1"
    bucket       = "cantor-terraform"
    key          = "terraform.tfstate"
    use_lockfile = true
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
