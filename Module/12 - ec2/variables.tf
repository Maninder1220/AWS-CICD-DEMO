variable "public_key" {}
variable "public_subnet_id" {}

variable "sg_id" {}

variable "assume_role_arn" {}


# TAG
variable "belongs_to" {
   type = string
   default = "Mahity"
  }