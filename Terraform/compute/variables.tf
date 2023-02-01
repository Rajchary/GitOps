variable "instance_count" {}
variable "instance_names" {}
variable "ami_id" {}
variable "instance_type" {}
variable "webServer_sg_id" {}
variable "subnet_ids" {}
variable "tg_products_arn" {}
variable "tg_home_arn" {}
variable "public_key" {}
variable "env" {}
variable "key_pair_name" {}

#======> AutoScaling Group Configuration (Stand-By)<======

# variable "max_instance_size" {}
# variable "min_instance_size" {}
# variable "desired_instance_size" {}
# variable "asg_name" {}
# variable "launch_template_name" {}