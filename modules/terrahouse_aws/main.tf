# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "bootcamp_bucket" {
  bucket = var.user-uuid

  tags = {
    Name        = var.name
    Environment = var.environment
  }
}


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration
resource "aws_s3_bucket_website_configuration" "bootcamp_bucket_website" {
  bucket = aws_s3_bucket.bootcamp_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "index_object" {
  bucket =  aws_s3_bucket.bootcamp_bucket.bucket
  key    = "index.html"
  source = "var.error_html_file_path"

  etag = filemd5("var.error_html_file_path")
   #depends_on = [aws_s3_bucket_policy.bootcamp_bucket]

}

resource "aws_s3_object" "error_object" {
  bucket =  aws_s3_bucket.bootcamp_bucket.bucket
  key    = "error.html"
  source = "var.error_html_file_path"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("var.error_html_file_path")
   #depends_on = [aws_s3_bucket_policy.bootcamp_bucket]

}








# resource "aws_s3_bucket_acl" "bootcamp_bucket" {
#     bucket = aws_s3_bucket.bootcamp_bucket.id
#     acl    = "public-read"
#     depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
# }

# resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
#   bucket = aws_s3_bucket.bootcamp_bucket.id
#   rule {
#     object_ownership = "BucketOwnerPreferred"
#   }
#   #depends_on = [aws_s3_bucket_public_access_block.bootcamp_bucket]
# }

# resource "aws_iam_user" "bootcamp_bucket" {
#   name = "bootcamp_bucket"
# }

# # resource "aws_s3_bucket_public_access_block" "bootcamp_bucket" {
# #   bucket = aws_s3_bucket.bootcamp_bucket.id

# #   block_public_acls       = false
# #   block_public_policy     = false
# #   ignore_public_acls      = false
# #   restrict_public_buckets = false
# # }

# resource "aws_s3_bucket_policy" "bootcamp_bucket" {
#     bucket = aws_s3_bucket.bootcamp_bucket.id
#     policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Principal = "*"
#         Action = [
#           "s3:*",
#         ]
#         Effect = "Allow"
#         Resource = [
#           "arn:aws:s3:::${var.bootcamp_bucket_arn}",
#           "arn:aws:s3:::${var.bootcamp_bucket_arn}/*"
#         ]
#       },
#       {
#         Sid = "PublicReadGetObject"
#         Principal = "*"
#         Action = [
#           "s3:PutObject",
#         ]
#         Effect   = "Allow"
#         Resource = [
#           "arn:aws:s3:::${var.bootcamp_bucket_arn}",
#           "arn:aws:s3:::${var.bootcamp_bucket_arn}/*"
#         ]
#       },
#     ]
#   })
  
#  # depends_on = [aws_s3_bucket_public_access_block.bootcamp_bucket]
# }