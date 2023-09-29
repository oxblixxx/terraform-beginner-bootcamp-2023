# TERRAFORM CLOUD INTERGRATION
terraform {
  cloud {
    organization = "oxblixxx"

    workspaces {
      name = "aws-terraform"
    }
  }
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}