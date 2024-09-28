variable "environment" {
  type        = string
  description = "Define the infrastructure environment"
}

variable "public_key" {
  type        = string
  description = "Path to the Public ssh key"
}

variable "security_group_allow_ssh" {
  description = "Import security group to allow ssh in EC2 instance"
  type        = string
}

variable "instance_type" {
  type        = string
  description = "server size"
  default     = "t3.micro"
}

variable "tag_name" {
  type        = string
  description = "tag name"
}

variable "subnet_ec2_public_az_a" {
  type        = string
  description = "assign subnet with load balancer in avaliability zone A"
}

variable "subnet_ec2_public_az_b" {
  type        = string
  description = "assign subnet with load balancer in avaliability zone B"
}

variable "count_instance" {
  type        = number
  description = "Number of instances"
}
