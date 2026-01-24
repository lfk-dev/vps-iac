# `provider` block configures the AWS Provider itself (AWS provided keys)
# syntax: https://developer.hashicorp.com/terraform/language/block/provider

# Terraform itself has only 2 keys: alias and version(deprecated).
# The rest is provider specific.
# Source: https://registry.terraform.io/providers/hashicorp/aws/latest/docs#aws-configuration-reference


provider "aws" {
  region = "eu-central-1"
  # access_key and secret_key are read from the env, by terraform
}
