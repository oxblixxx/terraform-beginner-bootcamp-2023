# # TERRAFORM CLOUD INTERGRATION
# terraform {
#   cloud {
#     organization = "oxblixxx"

#     workspaces {
#       name = "aws-terraform"
#     }
#   }
# }


# terraform {
#   required_providers {
#     terratowns = {
#       source  = "local.providers/local/terratowns"
#       version = "1.0.0"
#     }
#   }
# }

provider "terratowns" {
    endpoint = "https://terratowns.cloud/api"
    user_uuid="var.user_ussid" 
    token="var.token"
}