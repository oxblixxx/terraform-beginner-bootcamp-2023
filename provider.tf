# # TERRAFORM CLOUD INTERGRATION
# terraform {
#   cloud {
#     organization = "oxblixxx"

#     workspaces {
#       name = "aws-terraform"
#     }
#   }
# }

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}
# terraform {
#   backend "local" {
#     path = "terraform.tfstate"
#   }
# }

terraform {
  backend "s3" {
    bucket = "cloud-my-s3-bucket-25-05-2023"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
