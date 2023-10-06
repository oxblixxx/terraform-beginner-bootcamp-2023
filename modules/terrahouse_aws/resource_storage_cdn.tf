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

# https://developer.hashicorp.com/terraform/language/resources/terraform-data
resource "terraform_data" "content_version" {
  input = var.content_version
}


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "index_object" {
  bucket =  aws_s3_bucket.bootcamp_bucket.bucket
  key    = "index.html"
  source = var.index_html_file_path
  content_type = "text/html"

  etag = filemd5(var.index_html_file_path)

# https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle
  lifecycle {
    replace_triggered_by = [terraform_data.content_version]
    ignore_changes = [etag]
  }

}

resource "aws_s3_object" "error_object" {
  bucket =  aws_s3_bucket.bootcamp_bucket.bucket
  key    = "error.html"
  source = var.error_html_file_path
  content_type = "text/html"


  etag = filemd5(var.error_html_file_path)
}

resource "aws_s3_object" "assets_object" {
  bucket =  aws_s3_bucket.bootcamp_bucket.bucket
  key    =  "assets/each.key"
  for_each = fileset(var.assets_path, "*.jpeg")
  source = "${var.assets_path}/${each.key}"
  #content_type = "text/html"


  etag = filemd5("${path.root}/public/assets/${each.key}")


  lifecycle {
    replace_triggered_by = [terraform_data.content_version]
    ignore_changes = [etag]
  }
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

