output "bootcamp-bucket" {
  value = module.portfolio_aws.bootcamp-bucket
}


output "bootcamp-bucket_website_domain" {
  value = module.portfolio_aws.bootcamp-bucket_Website_domain
}

output "cdn_s3_distribution_id" {
  value = module.portfolio_aws.cdn_s3_distribution_id
}

output "cdn_s3_distribution_domain" {
  value = module.portfolio_aws.cdn_s3_distribution_domain
}
