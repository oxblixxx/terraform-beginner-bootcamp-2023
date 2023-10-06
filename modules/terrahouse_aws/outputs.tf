output "bootcamp-bucket" {
  value = aws_s3_bucket.bootcamp_bucket.bucket
}

output "bootcamp-bucket_Website_domain" {
  value = aws_s3_bucket_website_configuration.bootcamp_bucket_website
}

output "cdn_s3_distribution_id" {
  value = aws_cloudfront_distribution.s3_distribution.id
}