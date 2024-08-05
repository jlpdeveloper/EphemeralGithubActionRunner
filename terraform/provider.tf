provider "aws" {
  region = var.region
  default_tags {
    tags = {
      service = "gha-ephemeral-runner"
    }
  }

}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}