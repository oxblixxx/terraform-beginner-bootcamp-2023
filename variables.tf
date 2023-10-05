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


variable "user-uuid" {
  description = "Exampro user-uuid"
}

variable "bootcamp_bucket_arn" {
  description = "bootcamp bucket arn"
}


# variable "index_html_file_path" {
#   type = string
#   description = "file path to index.html file"
# }



# variable "error_html_filepath" {
#   type = string
#   description = "file path to index.html file"
# }
