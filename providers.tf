terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "curiositycorp"

    workspaces {
      name = "test-env"
    }
  }
}
provider "aws" {
  region  = "us-east-1"
}