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


# module "r53" {
#     source = "../module/r53"
#     #records = module.ec2.aws_eip #[aws_eip.eip.public_ip]
    
# }

