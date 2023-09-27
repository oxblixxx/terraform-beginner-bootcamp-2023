variable "name" {
    type = string
    description = "AWS Terraform Bootcamp 2023"
}

variable "environment" {
    type = string
}

variable "user-uuid" {
    description = "Exampro user-uuid"
# https://developer.hashicorp.com/terraform/language/expressions/custom-conditions#input-variable-validation    
     validate {
    condition = length(var.bucket) >= 3 && length(var.bucket) <= 63
    error_message = "The name of the S3 bucket must be between 3 and 63 characters long."
  }
}