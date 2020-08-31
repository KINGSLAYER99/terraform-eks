variable "cluster_name" {}

variable "vpc_id" {}

variable "subnets" {}

variable "master_asg_desired_capacity" {}

variable "master_asg_max_size" {}

variable "master_asg_min_size" {}

variable "master_instance_type" {}

variable "slave_asg_desired_capacity" {}

variable "slave_asg_max_size" {}

variable "slave_asg_min_size" {}

variable "slave_instance_type" {}

variable "spot_asg_desired_capacity" {}

variable "spot_asg_max_size" {}

variable "spot_asg_min_size" {}

variable "spot_instance_type" {}

variable "spot_price" {}

variable "cluster_enabled_log_types" {}

variable "user_id" {}

variable "user_name" {}