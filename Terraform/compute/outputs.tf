output "home_app_ip" {
  value = aws_instance.home_app.*.public_ip
}

output "products_app_ip" {
  value = aws_instance.products_app.*.public_ip
}