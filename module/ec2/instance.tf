resource "aws_instance" "IP_example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  # Security group assign to instance
  #vpc_security_group_ids = aws_security_group.allow_ssh.id
  # security_groups = "${var.security_group}"
 # private_ip = "10.0.1.10"
  # key name
  key_name = var.key_name

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

resource "aws_eip" "eip" {
  instance = aws_instance.IP_example.id
  vpc      = true
}
output "aws_eip" {
  value = aws_eip.eip.public_ip
}
output "public_ip" {
  value = aws_instance.IP_example.public_ip
}

output "ec2_arn" {
  value = aws_instance.IP_example.arn
}
output "ec2_instance_state" {
  value = aws_instance.IP_example.instance_state
}
output "ec2_public_dns" {
  value = aws_instance.IP_example.public_dns
}

# output "subnet_id" {
#   value = aws_subnet.public-1.id
# }


