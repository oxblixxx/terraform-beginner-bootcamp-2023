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

provider "random" {
  # Configuration options
}


resource "random_string" "bucket-name" {
  length = 8
  special = false
  override_special = ""
  lower = false
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