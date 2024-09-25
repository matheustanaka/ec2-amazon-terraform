output "security_group_allow_ssh" {
  value = aws_security_group.allow_ssh.id
}

output "subnet_ec2_public_az_a" {
  value = aws_subnet.subnet_ec2_public_az_a.id
}

output "subnet_ec2_public_az_b" {
  value = aws_subnet.subnet_ec2_public_az_b.id
}

output "vpc_ec2" {
  value = aws_vpc.vpc_ec2.id
}
