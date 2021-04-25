/*==== Outputs for Infrastructure ====*/ 
output "vpc_id" {
  value = aws_vpc.awslab-vpc.id
}
output "vpcCIDRblock" {
  value = aws_vpc.awslab-vpc.cidr_block
}
output "awslab-subnet-public-id" {
  value = aws_subnet.awslab-subnet-public.id
}
output "awslab-subnet-private-id" {
  value = aws_subnet.awslab-subnet-private.id
}
