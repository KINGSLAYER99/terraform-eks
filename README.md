# terraform-eks
IaaC for EKS setup
This code uses the terraform-eks module.
This works on linux systems only.
after terraform apply, you get a KUBECONFIG FILE. To use that file, simply do EXPORT KUBECONFIG="FILENAME", now you would be able to use all KUBECTL commands
