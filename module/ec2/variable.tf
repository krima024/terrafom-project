# variable "ec2_count"{
#     default = "1"
# }

variable "region" {
 
  default = "us-east-1"
}
variable "ami_id" {
    
    default =  "ami-0022f774911c1d690"
  }

variable "instance_type" {

  default = "t2.micro"
}

# variable "device_name" {
#   type    = "string"
#   default = "/dev/xvdh"
# }
variable "key_name" {
 
  default = "RDSKEY"
}
variable "subnet_id" {
   type = string

}

variable "security_group" {
  type = string
}

