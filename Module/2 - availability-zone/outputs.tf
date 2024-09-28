output "selected_azs" {
  value = random_shuffle.az.result
}