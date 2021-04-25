/*==== Set the AWS provider ====*/ 
provider "aws" {
  profile = "default"
  region  = var.region
}