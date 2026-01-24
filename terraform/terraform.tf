# `terraform` block specifies the required providers
# syntax: https://developer.hashicorp.com/terraform/language/block/terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "local" {} # default
}
