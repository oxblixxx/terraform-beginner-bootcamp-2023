# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "bootcamp-bucket" {
  bucket = var.user-uuid

  tags = {
    Name        = var.name
    Environment = var.environment
  }
}

