output "alb_endpoint" {
  value = module.loadbalancing.alb_dns
}

output "home_app_ip_address" {
  value = module.compute.home_app_ip
}
output "products_app_ip_address" {
  value = module.compute.products_app_ip
}
output "inventory" {
  value = templatefile(
    "${path.module}/templates/inventory.tpl",
    {
      home_app     = module.compute.home_app_ip,
      products_app = module.compute.products_app_ip,
    }
  )
}
output "known_hosts" {
  value = templatefile(
    "${path.module}/templates/known_hosts.tpl",
    {
      hostname = data.sshclient_host.host.*.hostname,
      keyscan  = data.sshclient_keyscan.keyscan,
    }
  )
  sensitive = true
}
#Adding some changes