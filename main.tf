
module "portfolio_aws" {
  source          = "./modules/portfolio_aws"
  user-uuid       = var.user_uuid
  environment     = var.environment
  name            = var.name
  token           = var.token
  portfolio       = var.portfolio.public_path
  content_version = var.content_version
}

