terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
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
}


output "bucket-name" {
  value = random_string.bucket-name.result
}