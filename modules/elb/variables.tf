variable "security_group_allow_ssh" {
  type        = string
  description = "Import security group to allow ssh in EC2"
}

variable "subnet_ec2_public_az_a" {
  type        = string
  description = "assign subnet with load balancer in avaliability zone A"
}

variable "subnet_ec2_public_az_b" {
  type        = string
  description = "assign subnet with load balancer in avaliability zone B"
}

variable "vpc_ec2" {
  type        = string
  description = "Assign VPC with Load Balancer"
}

variable "ec2" {
  type        = string
  description = "Assign EC2 instance"
}
