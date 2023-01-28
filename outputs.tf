output "alb_endpoint" {
  value = module.loadbalancing.alb_dns
}

output "home_app_ip_address" {
  value = module.compute.home_app_ip
}
output "products_app_ip_address" {
  value = module.compute.products_app_ip
}
output "inventory"{
  value = templatefile(
    "${path.module}/templates/inventory.tpl",
    {
      home_app     = module.compute.home_app_ip,
      products_app = module.compute.products_app_ip,
    }
  )
}
#Adding some changes