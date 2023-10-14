/*
module "terrahouse_aws" {
  source               = "./modules/terrahouse_aws"
  user-uuid            = var.user-uuid
  environment          = var.environment
  name                 = var.name
  bootcamp_bucket_arn  = var.bootcamp_bucket_arn
  error_html_file_path = var.error_html_file_path
  index_html_file_path = var.index_html_file_path
  content_version      = var.content_version
  assets_path = var.assets_path
  # cdn_invalidate_path = var.cdn_invalidate_path
}
*/

resource "terratowns_home" "home" {
  name = "How to play Arcanum in 2023!"
  description = <<DESCRIPTION
Arcanum is a game from 2001 that shipped with alot of for big ox.
Modders have removed all the originals making this game really fun
to play (despite that old look graphics). This is my guide that will
show you how to play arcanum without spoiling the plot.
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "3fdq3gaz.cloudfront.net"
  town = "missingo"
  content_version = 1
}