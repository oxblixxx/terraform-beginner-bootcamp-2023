output "bucket-name" {
  value = random_string.bucket-name.result
}

output "bootcamp-bucket" {
  value = aws_s3_bucket.bootcamp-bucket.bucket
}