variable "cluster_name" {
  description = "Cluster name for EKS cluster"
  default = "dev-eks-cluster"
}

variable "master_asg_desired_capacity" {
  description = "Desired number of instances in ASG for master"
  default = 3
}

variable "master_asg_max_size" {
  description = "maximum number of instances in ASG for master"
  default = 3
}

variable "master_asg_min_size" {
  description = "Min number of instances for master"
  default = 3
}

variable "master_instance_type" {
  description = "Instance type for worker group master"
  default = "t3a.micro"
}

variable "slave_asg_desired_capacity" {
  description = "Desired number of instances in ASG for slave"
  default = 3
}

variable "slave_asg_max_size" {
  description = "maximum number of instances in ASG for slave"
  default = 3
}

variable "slave_asg_min_size" {
  description = "Min number of instances for slave"
  default = 3
}

variable "slave_instance_type" {
  description = "Instance type for worker group slave"
  default = "t3a.micro"
}

variable "spot_asg_desired_capacity" {
  description = "Desired number of instances in ASG for spot"
  default = 3
}

variable "spot_asg_max_size" {
  description = "maximum number of instances in ASG for spot"
  default = 3
}

variable "spot_asg_min_size" {
  description = "Min number of instances for spot"
  default = 3
}

variable "spot_instance_type" {
  description = "Instance type for worker group spot"
  default = "t3a.micro"
}

variable "spot_price" {
  description = "Price for Spot Instances"
  default = "0.004"
}

variable "cluster_enabled_log_types" {
  description = "To enable CloudWatch Logs for the services"
  default = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "user_id" {
  description = "AWS User Id of user having necessary permissions to operate with EKS"
  default = "YOUR 12 DIGIT Account ID"
}

variable "user_name" {
  description = "AWS Username of user having necessary permissions to operate with EKS"
  default = "YOUR AWS Account USERNAME"
}
