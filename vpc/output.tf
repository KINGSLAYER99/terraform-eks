output "vpc_id" {
	value = aws_vpc.vpc.id
}
output "private_subnetA_id" {
	value = aws_subnet.subnet_privateA.id
}
output "private_subnetB_id" {
	value = aws_subnet.subnet_privateB.id
}
output "private_subnetC_id" {
	value = aws_subnet.subnet_privateC.id
}