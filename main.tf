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


resource "random_string" "bucket-name" {
  length = 15
  special = false
  override_special = ""
  upper = false
}


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "bootcamp-bucket" {
  bucket = random_string.bucket-name.result

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}



output "bucket-name" {
  value = random_string.bucket-name.result
}

output "bootcamp-bucket" {
  value = aws_s3_bucket.bootcamp-bucket.bucket
}