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

variable "bootcamp_bucket_arn" {
  description = "bootcamp bucket arn"
}


variable "index_html_file_path" {
  type = string
  description = "file path to index.html file"

  validation {
  condition = fileexists(var.index_html_file_path)
  error_message = "file does not exist, please create one"  
  }
}


variable "error_html_file_path" {
  type = string
  description = "file path to error.html file"

  validation {
    condition = fileexists(var.error_html_file_path)
    error_message = "file does not exist, please create one"  
  }
}
