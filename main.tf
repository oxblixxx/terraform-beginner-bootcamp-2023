module "consul" {
  source = "./modules/terrahouse_aws"
  user-uuid = var.user-uuid
  environment = var.environment
  name = var.name
}
