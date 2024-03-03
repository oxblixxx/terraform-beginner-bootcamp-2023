
module "terrahouse_aws" {
  source                = "./modules/terrahouse_aws"
  user-uuid             = var.user_uuid
  environment           = var.environment
  name                  = var.name
  token                 = var.token
  portfolio = var.portfolio.public_path
  #bootcamp_bucket_arn = var.bootcamp_bucket_arn
  content_version = var.content_version
  # cdn_invalidate_path = var.cdn_invalidate_path
}

