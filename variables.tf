variable "name" {
  type        = string
  description = "Portfolio Website"
  default = "porfolio-website"
}

variable "environment" {
  type = string
  default = "dev"
}


variable "user_uuid" {
  description = "Portfolio Website"
}

variable "content_version" {
  type        = number
  description = "variable for lifecycle for positive interger"
}

variable "token" {
  type        = string
  description = "public path"
}
variable "portfolio" {
  type = object({
    public_path     = string
    content_version = number
  })
}

