/*==== Variables for infrastructure ====*/ 
variable "region" {
     default     = "us-east-2"
     description = "AWS Region"
}
variable "vpcCIDRblock" {
    description = "VPC CIDR Block"
}
variable "dnsSupport" {
    default = true
}
variable "dnsHostNames" {
    default = true
}
variable "publicSubnetCIDRblock" {
    description = "Public Subnet"
}
variable "availabilityZone" {
     default = "us-east-2a"
}
variable "mapPublicIP" {
    default = true
}
variable "privateSubnetCIDRblock" {
    description = "Private Subnet"
}
variable "destinationCIDRblock" {
    description = "Internet Access"
}