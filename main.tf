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
    Name        = var.user-uuid
    Environment = var.environment
  }
}



