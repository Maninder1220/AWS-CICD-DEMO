# AVAILABILITY ZONE

data "aws_availability_zones" "available_zones" {
  state = "available"
}



# Randomly Select AZ
resource "random_shuffle" "az" {
  input = data.aws_availability_zones.available_zones.names
  result_count = var.subnet_count
}