# `terraform` block specifies the required providers
# syntax: https://developer.hashicorp.com/terraform/language/block/terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "terrafrom-vps-state"
    key    = "envs/dev/terraform.tfstate" # the path to the state file in the bucket
    # no locking file needed (solo project) but there could be dynamoDB configured here
    region = "eu-central-1"
    # credentials are in env vars
  }


}
