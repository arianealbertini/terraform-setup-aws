/*==== Variables for backend ====*/ 
variable "region" {
  default     = "us-east-2"
  description = "AWS Region"
}
variable "availabilityZone" {
  default = "us-east-2a"
}
variable "remoteStateBucket" {
  description = "Bucket name for layer 1 remote state"  
}
variable "remoteStateKey" {
  description = "Key name for layer 1 remote state"  
}
variable "ingressCIDRblock" {
    type = list
}
variable "ingressCIDRblockCustom" {
    type = list
}
variable "egressCIDRblock" {
    type = list
}
variable "keyPairName" {
    default     = "ec2KeyPair_ariane"
    description = "Keypair to use to connect to EC2 instances"
}