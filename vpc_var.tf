variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default = "10.0.0.0/16"
}
variable "cidr_Public_subnetA" {
  description = "CIDR block for the public subnet A"
  default = "10.0.0.0/20"
}
variable "cidr_Public_subnetB" {
  description = "CIDR block for the public subnet B"
  default = "10.0.16.0/20"
}
variable "cidr_Public_subnetC" {
  description = "CIDR block for the public subnet C"
  default = "10.0.32.0/20"
}
variable "cidr_Private_subnetA" {
  description = "CIDR block for the private subnet A"
  default = "10.0.48.0/20"
}
variable "cidr_Private_subnetB" {
  description = "CIDR block for the private subnet B"
  default = "10.0.64.0/20"
}
variable "cidr_Private_subnetC" {
  description = "CIDR block for the private subnet C"
  default = "10.0.80.0/20"
}
variable "availability_zoneA" {
  description = "availability zone to create subnet A series"
  default = "ap-south-1a"
}
variable "availability_zoneB" {
  description = "availability zone to create subnet B series"
  default = "ap-south-1b"
}
variable "availability_zoneC" {
  description = "availability zone to create subnet C series"
  default = "ap-south-1c"
}
variable "environment_tag" {
  description = "Environment tag"
  default = "Trial"
}