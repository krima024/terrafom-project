provider "aws" {
    region = "us-east-1"
}
module "vpc" {
    source = "../module/vpc"
   
}

module "ec2" {
    source = "../module/ec2"
    subnet_id = module.vpc.subnet_id
    security_group = module.vpc.security_group
}


module "r53" {
    source = "../module/r53"
    # ec2_count = 1
}