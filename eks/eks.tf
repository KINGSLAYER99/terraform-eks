module "eks-cluster" {
 # depends_on = [module.vpc]
  source = "terraform-aws-modules/eks/aws"
  version = "v7.0.1"
  cluster_name = var.cluster_name
  vpc_id  = var.vpc_id
  subnets = var.subnets
  worker_groups = [
    {
      subnets = var.subnets
      asg_desired_capacity = var.master_asg_desired_capacity
      asg_max_size = var.master_asg_max_size
      asg_min_size = var.master_asg_min_size
      instance_type = var.master_instance_type
      name = "master"
      additional_userdata = "Worker group 1 configurations"
      tags = [{
          key                 = "worker-group-tag"
          value               = "Master"
          propagate_at_launch = true
      }]
    },
    {
      subnets = var.subnets
      asg_desired_capacity = var.slave_asg_desired_capacity
      asg_max_size = var.slave_asg_max_size
      asg_min_size = var.slave_asg_min_size
      instance_type = var.slave_instance_type
      name = "slave"
      additional_userdata = "Worker group 2 configurations"
      tags = [{
          key                 = "worker-group-tag"
          value               = "Slave"
          propagate_at_launch = true
      }]
    },
    {
      subnets = var.subnets
      spot_price = var.spot_price
      asg_desired_capacity = var.spot_asg_desired_capacity
      asg_max_size = var.spot_asg_max_size
      asg_min_size = var.spot_asg_min_size
      instance_type = var.spot_instance_type
      name = "spot"
      additional_userdata = "Worker group 3 configurations"
      tags = [{
          key                 = "worker-group-tag"
          value               = "Spot"
          propagate_at_launch = true
      }]
    }
  ]
  map_users = [
      {
        userarn = join("",["arn:aws:iam::", var.user_id, ":user/", var.user_name])
        username = var.user_name
        groups = ["system:masters"]
      },
    ]
  cluster_enabled_log_types = var.cluster_enabled_log_types
  tags = {
    Name = "My CLuster"
    environment = "dev-env"
  }
}