variable "name" {
  type        = string
  description = "AWS Terraform Bootcamp 2023"
}

variable "environment" {
  type = string
}

variable "user-uuid" {
  description = "Exampro user-uuid"
  # https://developer.hashicorp.com/terraform/language/expressions/custom-conditions#input-variable-validation    
  validation {
    condition     = length(var.user-uuid) >= 3 && length(var.user-uuid) <= 63
    error_message = "The name of the S3 bucket must be between 3 and 63 characters long."
  }
}


variable "content_version" {
  type = number
  validation {
    condition = var.content_version > 0
    error_message = "The positive_integer variable must be a positive integer greater than zero."
  }
}

variable "portfolio" {
  type = string
  description = "public path"
}

variable "token" {
  type = string
  description = "public path"
}