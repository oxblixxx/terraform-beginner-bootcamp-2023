
# variable "private-ip" {
#   description = "webserver EC2 private ip"  
# }


variable "name" {
  type        = string
  description = "AWS Terraform Bootcamp 2023"
}

variable "environment" {
  type = string
}


variable "user_uuid" {
  description = "Exampro user-uuid"
}

variable "bootcamp_bucket_arn" {
  description = "bootcamp bucket arn"
}




variable "content_version" {
  type        = number
  description = "variable for lifecycle for positive interger"
}

# variable "cdn_invalidate_path" {
#   type        = string
#   description = "file path to cdn invalidate file"
# }




# variable "token" {
#   type        = string
#   description = "AWS Terraform Bootcamp 2023"
# }


# variable "user_uuid" {
#   type        = string
#   description = "AWS Terraform Bootcamp 2023"
# }

variable "token" {
  type        = string
  description = "public path"
}
variable "astra" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "culinaris" {
  type = object({
    public_path = string
    content_version = number
  })
}