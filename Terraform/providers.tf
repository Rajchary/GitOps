terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    github = {
      source  = "integrations/github"
      version = "4.23.0"
    }

    sshclient = {
      source  = "luma-planet/sshclient"
      version = "1.0.1"
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
  region = "us-east-1"
}
provider "github" {

}

provider "sshclient" {

}