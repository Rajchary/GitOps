output "alb_endpoint" {
  value = module.loadbalancing.alb_dns
}

output "home_app_ip_address" {
  value = module.compute.home_app_ip
}
output "products_app_ip_address" {
  value = module.compute.products_app_ip
}
#Adding new feature