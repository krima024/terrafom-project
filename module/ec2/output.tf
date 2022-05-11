output "aws_eip" {
  value = aws_eip.lb.public_ip
}
output "public_ip" {
  value = aws_instance.web.public_ip
}

output "ec2_arn" {
  value = aws_instance.web.arn
}
output "ec2_instance_state" {
  value = aws_instance.web.instance_state
}
output "ec2_public_dns" {
  value = aws_instance.web.public_dns
}

output "name_server"{
  value=aws_route53_zone.easy_aws.name_servers
}
