# SUBNET
variable "private_subnet_cidr" {}
variable "public_subnet_cidr" {}

# VPC
variable "vpc_id" {}


# Random AZ
variable "selected_azs" {}


# TAG
variable "belongs_to" {
   type = string
   default = "Mahity"
  }