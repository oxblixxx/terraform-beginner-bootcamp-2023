#!/bin/bash

# Your setup commands go here
source '/workspaces/terraform-beginner-bootcamp-2023/bin/terraform'
source '/workspaces/terraform-beginner-bootcamp-2023/bin/create_credentials_trfc'
source '/workspace/terraform-beginner-bootcamp-2023/bin/tf_alias'
source '/workspaces/terraform-beginner-bootcamp-2023/bin/tf_alias'
cp '/workspace/terraform-beginner-bootcamp-2023/terraform.tfvars.example' '/workspace/terraform-beginner-bootcamp-2023/variables.tfvars'
source ~/.bash_profile
nano /home/codespace/.terraform.d/credentials.tfrc.json

# Install aws-cli
#source '/workspace/terraform-beginner-bootcamp-2023/bin/aws'
source '/workspaces/terraform-beginner-bootcamp-2023/bin/aws'

# Install http-server
npm install --global http-server
