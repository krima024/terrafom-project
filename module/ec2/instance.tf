
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  # Security group assign to instance
  #vpc_security_group_ids = aws_security_group.allow_ssh.id
  # security_groups = "${var.security_group}"
 # private_ip = "10.0.1.10"
  # key name
  key_name = "RDSKEY"

  user_data = <<EOF
    #! /bin/bash
                sudo yum update -y
    sudo yum install -y httpd
    sudo service httpd start
    sudo service httpd enable
    echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
  EOF

  tags = {
    Name = "Practice"
  }
}

# route53  
resource "aws_route53_zone" "easy_aws" {
  name = "manhardangar.ml"

  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.easy_aws.zone_id
  name    = "www.manhardangar.ml"
  type    = "A"
  ttl     = "30"

  #records = module.ec2.aws_eip
  records = [aws_eip.lb.public_ip]
  #records = aws_route53_zone.easy_aws.name_servers
}


# output "name_server"{
#   value=aws_route53_zone.easy_aws.name_servers
# }
resource "aws_eip" "lb" {
  instance = aws_instance.web.id
  vpc      = true
}

# output "aws_eip" {
#   value = aws_eip.lb.public_ip
# }
# output "public_ip" {
#   value = aws_instance.web.public_ip
# }

# output "ec2_arn" {
#   value = aws_instance.web.arn
# }
# output "ec2_instance_state" {
#   value = aws_instance.web.instance_state
# }
# output "ec2_public_dns" {
#   value = aws_instance.web.public_dns
# }
