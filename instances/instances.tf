# Set s3 to remote state files
terraform {
    backend "s3" {}
}

# S3 configurations 
data "terraform_remote_state" "network-configuration" {
  backend = "s3"
  config  = {
      region = var.region
      bucket = var.remoteStateBucket
      key    = var.remoteStateKey           
  }
}

/*==== Security Groups, EC2 Instances ====*/
# Create the Public Security Group 
resource "aws_security_group" "awslab-security-group-public" {
  vpc_id       = data.terraform_remote_state.network-configuration.outputs.vpc_id
  name         = "awslab-security-group-public"
  description  = "Security Group Public Ports: HTTP/ICMP/SSH"
  
  # allow ingress of port 80
  ingress {
    cidr_blocks = var.ingressCIDRblock  
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  } 
  # allow ingress of port 0-65535
  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
  } 
  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
 
  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egressCIDRblock
  }
tags = {
   Name        = "awslab-security-group-public"
   Description = "Security Group Public Ports: HTTP/ICMP/SSH"
}
} # end Public Security Group resource

# Create the Private Security Group 
resource "aws_security_group" "awslab-security-group-private" {
  vpc_id       = data.terraform_remote_state.network-configuration.outputs.vpc_id
  name         = "awslab-security-group-private"
  description  = "Security Group Private Ports: Custom DB Port/ICMP/SSH"

  # allow ingress the Public Security Group
  ingress {
    security_groups = [aws_security_group.awslab-security-group-public.id]
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
  }
  # allow ingress of port 3110
  ingress {
    cidr_blocks = var.ingressCIDRblockCustom
    from_port   = 3110
    to_port     = 3110
    protocol    = "tcp"
  }
  # allow ingress of ports 0-65535
  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
  } 
  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblockCustom
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
    # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egressCIDRblock
  }

tags = {
   Name        = "awslab-security-group-private"
   Description = "Security Group Private Ports: Custom DB Port/ICMP/SSH"
}
} # end Private Security Group resource

# Create EC2 - webserver
resource "aws_instance" "awslab-webserver" {
  ami                         = "ami-023c8dbf8268fb3ca"
  availability_zone           = var.availabilityZone
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.awslab-security-group-public.id]
  subnet_id                   = data.terraform_remote_state.network-configuration.outputs.awslab-subnet-public-id
  key_name                    = var.keyPairName 
  associate_public_ip_address = true
  
  tags = {
    Name = "awslab-webserver"
  }
} # end webserver resource

# Create EC2 - database
resource "aws_instance" "awslab-database" {
  ami                         = "ami-023c8dbf8268fb3ca"
  availability_zone           = var.availabilityZone
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.awslab-security-group-private.id]
  subnet_id                   = data.terraform_remote_state.network-configuration.outputs.awslab-subnet-private-id
  key_name                    = var.keyPairName 
  associate_public_ip_address = false

  tags = {
    Name = "awslab-database"
  }
} # end database resource



