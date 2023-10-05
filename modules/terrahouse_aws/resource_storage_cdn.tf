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
  source = "${path.root}/public/index.html"


 # etag = filemd5(var.index_html_file_path)
   #depends_on = [aws_s3_bucket_policy.bootcamp_bucket]

}

resource "aws_s3_object" "error_object" {
  bucket =  aws_s3_bucket.bootcamp_bucket.bucket
  key    = "error.html"
  source = "${path.root}/public/error.html"


#  etag = filemd5(var.error_html_filepath)
   #depends_on = [aws_s3_bucket_policy.bootcamp_bucket]

}


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy
resource "aws_s3_bucket_policy" "default" {
  bucket = aws_s3_bucket.bootcamp_bucket.id
  #policy = data.aws_iam_policy_document.allow_access_from_another_account.json
  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" =   {
      "Sid" = "AllowCloudFrontServicePrincipalReadOnly",
      "Effect" = "Allow",
      "Principal" = {
         "Service" = "cloudfront.amazonaws.com"
      },
      "Action" = "s3:GetObject",
      "Resource" = "arn:aws:s3:::${aws_s3_bucket.bootcamp_bucket.id}/*",
      "Condition" = {
      "StringEquals" = {
         "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
            }
          }
      }
    })
  }

