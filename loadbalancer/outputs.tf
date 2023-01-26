output "alb_dns" {
  value = "http://${aws_lb.ekart_alb.dns_name}"
}
output "products_tg_arn" {
  value = aws_lb_target_group.products_tg.arn
}
output "home_tg_arn" {
  value = aws_lb_target_group.home_tg.arn
}