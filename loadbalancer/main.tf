
# ================>  LoadBalancer main.tf  <===============#

resource "aws_lb" "ekart_alb" {
  name            = "PrimeStore-alb"
  subnets         = var.subnet_ids
  security_groups = [var.public_sg_id]
  idle_timeout    = 400
  tags = {
    "Env" = var.env
  }

}

resource "aws_lb_target_group" "home_tg" {
  name     = "homePage-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  lifecycle {
    ignore_changes        = [name]
    create_before_destroy = true
  }
  tags = {
    "Env" = var.env
  }
}

resource "aws_lb_target_group" "products_tg" {
  name     = "productsPage-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path = "/products/"
  }
  lifecycle {
    ignore_changes        = [name]
    create_before_destroy = true
  }
  tags = {
    "Env" = var.env
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.ekart_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.home_tg.arn
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "lr" {
  listener_arn = aws_lb_listener.lb_listener.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.products_tg.arn
  }
  condition {
    path_pattern {
      values = ["*/products*"]
    }
  }
}