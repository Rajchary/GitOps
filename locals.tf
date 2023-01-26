locals {
  security_groups = {
    webServer = {
      name        = "WebServerSG"
      description = var.webServerDesc
      ingress = {
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
    alb_sg = {
      name        = "AlbSg"
      description = "allows http"
      ingress = {
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
  }
}
