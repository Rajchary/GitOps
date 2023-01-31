output "vpc_id" {
  value = aws_vpc.ekart_vpc.id
}
output "subnet_ids" {
  value = aws_subnet.ekart_public_subnet.*.id
}
output "albsg_id" {
  value = aws_security_group.ekart_albsg.id
}
output "websg_id" {
  value = aws_security_group.ekart_websg.id
}
output "azs" {
  value = data.aws_availability_zones.available.names
}