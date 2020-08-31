# specifies version of terraform required to run the setup
terraform {
  required_version = ">= 0.12.7"
}

# specifies the provider
provider "aws" {
  region  = var.region
}

# specifies all the variables required for VPC module defined in current directory to be created
module "vpc" {
  source = "./vpc"
  cidr_vpc = var.cidr_vpc
  cidr_Public_subnetA = var.cidr_Public_subnetA
  cidr_Public_subnetB = var.cidr_Public_subnetB
  cidr_Public_subnetC = var.cidr_Public_subnetC
  cidr_Private_subnetA = var.cidr_Private_subnetA
  cidr_Private_subnetB = var.cidr_Private_subnetB
  cidr_Private_subnetC = var.cidr_Private_subnetC
  availability_zoneA = var.availability_zoneA
  availability_zoneB = var.availability_zoneB
  availability_zoneC = var.availability_zoneC
  environment_tag = var.environment_tag
}

# specifies all the variables required for EKS module defined in terraform registry to be created
module "eks" {
 # depends_on = [module.vpc]
  source       = "./eks"
  cluster_name = var.cluster_name
  vpc_id  = module.vpc.vpc_id
  subnets = [module.vpc.private_subnetA_id, module.vpc.private_subnetB_id, module.vpc.private_subnetC_id]
  master_asg_desired_capacity = var.master_asg_desired_capacity
  master_asg_max_size = var.master_asg_max_size
  master_asg_min_size = var.master_asg_min_size
  master_instance_type = var.master_instance_type
  slave_asg_desired_capacity = var.master_asg_desired_capacity
  slave_asg_max_size = var.master_asg_max_size
  slave_asg_min_size = var.master_asg_min_size
  slave_instance_type = var.master_instance_type
  spot_asg_desired_capacity = var.spot_asg_desired_capacity
  spot_asg_max_size = var.spot_asg_max_size
  spot_asg_min_size = var.spot_asg_min_size
  spot_instance_type = var.spot_instance_type
  spot_price = var.spot_price
  user_id = var.user_id
  user_name = var.user_name
  cluster_enabled_log_types = var.cluster_enabled_log_types
}