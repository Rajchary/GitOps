variable "instance_count" {}
variable "instance_name" {}
variable "ami_id" {}
variable "instance_type" {}
variable "webServer_sg_id" {}
variable "subnet_ids" {}
variable "userData_path" {}
variable "template_userData_path" {}
variable "tg_products_arn" {}
variable "tg_home_arn" {}
variable "public_key" {}
variable "env" {}

#======> AutoScaling Group Configuration (Stand-By)<======

# variable "max_instance_size" {}
# variable "min_instance_size" {}
# variable "desired_instance_size" {}
# variable "asg_name" {}
# variable "launch_template_name" {}