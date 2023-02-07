variable "cidr_block_vpc" {
  type = string
}
variable "env" {
  default = "Prod"
}
variable "vpc_name" {
  type    = string
  default = "PrimeStore_vpc"
}
variable "public_sn_cidr" {
  type = list(any)
}
variable "public_sn_count" {
  default = 4
}
variable "webServerDesc" {
  type    = string
  default = "Allows HTTP from Application-load-balancer and SSH from anywhere"
}
variable "instance_count" {
  type    = number
  default = 1
}
variable "repo_name" {
  default = "Rajchary/GithubActions-Terrafrom-Ansible"
}
variable "key_pair_name" {
  default = "primeStore-key-pair"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "instance_names" {
  type = map(any)
  default = {
    "Home_App" : "Home-app"
    "Products_App" : "Products-app"
  }
}

variable "pub_key" {}
variable "ami_id" {}

#======> AutoScaling Group Configuration (Stand-By) <======

# variable asg_max_instance_size{}
# variable asg_min_instance_size{}
# variable asg_desired_instance_size{}
# variable "asg_name"{
#   default = "products_asg"
# }
# variable "launch_template_name" {
#   default = "products_launch_template"
# }