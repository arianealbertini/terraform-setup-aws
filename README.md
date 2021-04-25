# terraform-setup-aws

A Terraform module to create an Amazon Web Services (AWS) Virtual Private Cloud (VPC) and related resources.

## Usage

This module creates a VPC alongside a variety of related resources, including:

- Public and private subnets
- Public route table
- An Internet Gateway
- Security Groups
- A webserver EC2 instance
- A database EC2 instance

The project is divided in Infrastructure and Instances:

- Infrastructure - VPC, Subnets, Route Table, Internet Gateway
- Instances - Security Groups, EC2 Instances


## Variables


- `region` - Region of the VPC (default: `us-east-2`)
- `vpcCIDRblock` - CIDR block for the VPC (default: `172.16.0.0/16`)
- `dnsSupport` - Flag to enable/disable DNS support in the VPC (default: `true`)
- `dnsHostNames` -  Flag to enable/disable DNS hostnames in the VPC (default: `true`)
- `publicSubnetCIDRblock` - Public subnet CIDR blocks (default: `["172.16.1.0/24"]`)
- `availability_zones` - Availability zone (default: `["us-east-2a"]`)
- `mapPublicIP` - Public IP addresses are assigned on instance launch (default: `true`)
- `privateSubnetCIDRblock` - List of private subnet CIDR blocks (default: `["172.16.2.0/24"]`)
- `destinationCIDRblock` -  Internet Access (default: `["0.0.0.0/0"]`)
- `remoteStateBucket` -  Bucket name for layer 1 remote state (default: `terraform-remote-state-2021-04`)
- `remoteStateKey` -  Bucket name for layer 1 remote state (default: `"layer1/infrastructure.tfstate"`)
- `ingressCIDRblock` -  Allow all inbound IPv4 traffic (default: `0.0.0.0/0`)
- `ingressCIDRblockCustom` -  Subnet CIDR blocks configured in ingress (default: `172.16.1.0/24`)
- `egressCIDRblock` -  Allow all outbound IPv4 traffic (default: `0.0.0.0/0`)
- `keyPairName` -  Keypair to use to connect to EC2 instances (default: `"ec2KeyPair_ariane"`)



## Outputs

- `vpc_id` - VPC ID
- `vpcCIDRblock` - The CIDR block associated with the VPC
- `awslab-subnet-public-id` - Public subnet IDs
- `awslab-subnet-private-id` - Private subnet IDs


## TO BE

- Multiple subnets to configure fault tolerance and high availability with Multi-AZ
- Load Balancer
- Auto Scalling
