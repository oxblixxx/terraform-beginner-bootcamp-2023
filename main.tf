module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user-uuid = var.user-uuid
  environment = var.environment
  name = var.name
  # bootcamp_bucket_arn = var.bootcamp_bucket_arn
}
