# terraform-eks
IaaC for EKS setup
This code uses the terraform-eks module.
This works on linux systems only.
after terraform apply, you get a KUBECONFIG FILE. To use that file, simply do EXPORT KUBECONFIG="FILENAME", now you would be able to use all KUBECTL commands


	The cluster configurations are:
	3 worker groups with auto-scaling. Cluster logs enabled for cloudwatch. 6 subnets(3 private and 3 public). Separate NAT Gateway for each private subnet. Internet Gateway for public subnets to have access from internet. Worker Groups will be deployed in private subnets only
