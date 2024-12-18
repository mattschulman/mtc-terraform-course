# --- compute/variables.tf ---

variable "instance_count" {}
variable "instance_type" {}
variable "public_sg" {}
variable "public_subnets" {}
variable "vol_size" {}
variable "key_name" {}
variable "public_key_path" {}
variable "db_endpoint" {}
variable "dbuser" {}
variable "dbpassword" {}
variable "dbname" {}
variable "user_data_path" {}
variable "lb_target_group_arn" {}
variable "tg_port" {}
variable "private_key_path" {}