# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}



# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
data "aws_caller_identity" "current" {}








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