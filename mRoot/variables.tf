# VPC CIDER
variable "vpc_cider_block" {}

# SUBNET
variable "private_subnet_cidr" {}
variable "public_subnet_cidr" {}

# VPC #
# variable "vpc_id" {}

# Random AZ #
# variable "random_az" {}

 # NAT #
# variable "nat_gateway_id" {}


# Destination Cidr
variable "private_destination_cider" {}  # Private
variable "public_destination_cider" {}   # Public

# CICD ROLE NAME
variable "cicd_role_name" {}

# CODE COMMIT REPO NAME
variable "repo-one-name" {}

# CODE DEPLOY APP NAME
variable "code_deploy_app_name" {}

# CODE DEPLOY GROUP NAME
variable "deployment_group_one" {}

variable "pipeline_name" {}

variable "cc_trigger_codepipeline" {}