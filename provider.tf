terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
     aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

# TERRAFORM CLOUD INTERGRATION
terraform {
  cloud {
    organization = "oxblixxx"

    workspaces {
      name = "aws-terraform"
    }
  }
}


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {

}


provider "random" {
  # Configuration options
}
