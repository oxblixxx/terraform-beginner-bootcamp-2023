
module "terrahouse_aws" {
  source                = "./modules/terrahouse_aws"
  user-uuid             = var.user_uuid
  environment           = var.environment
  name                  = var.name
  token                 = var.token
  public_path = var.astra.public_path
  bootcamp_bucket_arn = var.bootcamp_bucket_arn
  content_version = var.content_version
  # cdn_invalidate_path = var.cdn_invalidate_path
}


resource "terratowns_home" "home" {
  name        = "How to play Arcanum in 2023!"
  description = <<DESCRIPTION
Arcanum is a game from 2001 that shipped with alot of for big ox.
Modders have removed all the originals making this game really fun
to play (despite that old look graphics). This is my guide that will
show you how to play arcanum without spoiling the plot.
DESCRIPTION
  domain_name = module.terrahouse_aws.cdn_s3_distribution_domain
  town            = "gamers-grotto"
  content_version = 1
}


module "culinaris" {
  source                = "./modules/terrahouse_aws"
  token                 = var.token
  user-uuid             = var.user_uuid
  public_path = var.culinaris.public_path
  environment           = var.environment
  name                  = var.name
  bootcamp_bucket_arn   = var.bootcamp_bucket_arn
  content_version = var.content_version
  # cdn_invalidate_path = var.cdn_invalidate_path
}


resource "terratowns_home" "culinary" {
  name        = "How to "
  description = <<DESCRIPTION
The lumiberry tale
DESCRIPTION
  domain_name = module.terrahouse_aws.cdn_s3_distribution_domain
  #domain_name     = "3fdq3gaz.cloudfront.net"
  town            = "cooker-cove"
  content_version = 1
}
