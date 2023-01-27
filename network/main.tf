# network main.tf
data "aws_availability_zones" "available" {

}

resource "aws_vpc" "ekart_vpc" {
  cidr_block           = var.vpc_cidrBlock
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = var.vpc_name
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "ekart_public_subnet" {
  count                   = var.public_sn_count
  cidr_block              = var.public_sn_cidr[count.index]
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.ekart_vpc.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    "Name" = "public_subnet_${count.index + 1}"
  }
}
resource "aws_internet_gateway" "ekart_igw" {
  vpc_id = aws_vpc.ekart_vpc.id
  tags = {
    Name = "ekart-igw"
  }
}

resource "aws_route_table" "ekart_public_rt" {
  vpc_id = aws_vpc.ekart_vpc.id
  tags = {
    "Name" = "PrimeStore_public_rt"
  }
}

resource "aws_route_table_association" "ekart_pub_rtasc" {
  count          = var.public_sn_count
  subnet_id      = aws_subnet.ekart_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.ekart_public_rt.id
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.ekart_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ekart_igw.id
}

resource "aws_security_group" "ekart_websg" {
  name        = var.web_security_groups.name
  description = var.web_security_groups.description
  vpc_id      = aws_vpc.ekart_vpc.id
  dynamic "ingress" {
    for_each = var.web_security_groups.ingress
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.ekart_albsg.id}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ekart_albsg" {
  name        = var.alb_security_groups.name
  description = var.alb_security_groups.description
  vpc_id      = aws_vpc.ekart_vpc.id
  dynamic "ingress" {
    for_each = var.alb_security_groups.ingress
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_security_group_rule" "alb_to_server_rule" {
#   type = "ingress"
#   from_port = 80
#   to_port = 80
#   protocol = "tcp"
#   source_security_group_id = aws_security_group.ekart_sg["alb_sg"].id
#   security_group_id = aws_security_group.ekart_sg["webServer"].id
# }
