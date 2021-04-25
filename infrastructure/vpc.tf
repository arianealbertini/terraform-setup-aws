# Set s3 to store remote state files
terraform {
    backend "s3" {}   
}
/*==== VPC, Subnets, Route Table, Internet Gateway ====*/
# Create the VPC
resource "aws_vpc" "awslab-vpc" {
  cidr_block           = var.vpcCIDRblock
  enable_dns_support   = var.dnsSupport 
  enable_dns_hostnames = var.dnsHostNames

  tags = {
    Name = "awslab-vpc"
  }
} # end VPC resource

# Create the Public Subnet
resource "aws_subnet" "awslab-subnet-public" {
  vpc_id                  = aws_vpc.awslab-vpc.id
  cidr_block              = var.publicSubnetCIDRblock
  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone

 tags = {
   Name = "awslab-subnet-public"
 }
} # end Public Subnet resource

# Create the Private Subnet
resource "aws_subnet" "awslab-subnet-private" {
  vpc_id                  = aws_vpc.awslab-vpc.id
  cidr_block              = var.privateSubnetCIDRblock
  map_public_ip_on_launch = false
  availability_zone       = var.availabilityZone

 tags = {
   Name = "awslab-subnet-private"
 }
} # end Private Subnet resource

# Create the Routing Table for public subnet
resource "aws_route_table" "awslab-rt-internet" {
 vpc_id = aws_vpc.awslab-vpc.id

 tags = {
   Name = "awslab-rt-internet"
 }
} # end Routing Table resource

# Associate the Route Table with the Public Subnet
resource "aws_route_table_association" "awslab-vpc-public-association" {
  subnet_id      = aws_subnet.awslab-subnet-public.id
  route_table_id = aws_route_table.awslab-rt-internet.id
} # end resource

# Create the Internet Gateway
resource "aws_internet_gateway" "awslab-internet-gateway" {
 vpc_id = aws_vpc.awslab-vpc.id

 tags = {
   Name = "awslab-internet-gateway"
 }
} # end Internet Gateway resource

# Create the Internet Access
resource "aws_route" "awslab-internet-access" {
  route_table_id         = aws_route_table.awslab-rt-internet.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.awslab-internet-gateway.id
} # end Internet Access resource


