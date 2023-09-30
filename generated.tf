# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
# resource "aws_instance" "webserver" {
#   ami                                  = "ami-053b0d53c279acc90"
#   associate_public_ip_address          = false
#   availability_zone                    = "us-east-1a"
#   disable_api_stop                     = false
#   disable_api_termination              = false
#   ebs_optimized                        = false
#   get_password_data                    = false
#   hibernation                          = false
#   host_id                              = null
#   host_resource_group_arn              = null
#   iam_instance_profile                 = null
#   instance_initiated_shutdown_behavior = "stop"
#   instance_type                        = "t2.micro"
#   ipv6_address_count                   = 0
#  # ipv6_addresses                       = []
#   key_name                             = "ox-2023-aug"
#   monitoring                           = false
#   placement_group                      = null
#   placement_partition_number           = 0
#   private_ip                           = var.private-ip
#   secondary_private_ips                = []
#   security_groups                      = ["launch-wizard-18"]
#   source_dest_check                    = true
#   subnet_id                            = "subnet-05cf617905fe2c4d4"
#   tags = {
#     Name = "web-server"
#   }
#   tags_all = {
#     Name = "web-server"
#   }
#   tenancy                     = "default"
#   user_data                   = null
#   user_data_base64            = null
#   user_data_replace_on_change = null
#   volume_tags                 = null
#   vpc_security_group_ids      = ["sg-0594d545344a114f9"]
#   capacity_reservation_specification {
#     capacity_reservation_preference = "open"
#   }
#   cpu_options {
#     amd_sev_snp      = null
#     core_count       = 1
#     threads_per_core = 1
#   }
#   credit_specification {
#     cpu_credits = "standard"
#   }
#   enclave_options {
#     enabled = false
#   }
#   maintenance_options {
#     auto_recovery = "default"
#   }
#   metadata_options {
#     http_endpoint               = "enabled"
#     http_protocol_ipv6          = "disabled"
#     http_put_response_hop_limit = 1
#     http_tokens                 = "optional"
#     instance_metadata_tags      = "disabled"
#   }
#   private_dns_name_options {
#     enable_resource_name_dns_a_record    = true
#     enable_resource_name_dns_aaaa_record = false
#     hostname_type                        = "ip-name"
#   }
#   root_block_device {
#     delete_on_termination = true
#     encrypted             = false
#     iops                  = 100
#     kms_key_id            = null
#     tags                  = {}
#     throughput            = 0
#     volume_size           = 8
#     volume_type           = "gp2"
#   }
# }