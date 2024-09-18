provider "aws" {
  profile = "matheus"
  region  = "us-east-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_vpc" "vpc_ec2" {
  cidr_block       = "10.0.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-ec2"
  }
}

resource "aws_internet_gateway" "igw_ec2" {
  vpc_id = aws_vpc.vpc_ec2.id

  tags = {
    Name = "igw-ec2"
  }
}

resource "aws_route_table" "rtb_ec2" {
  vpc_id = aws_vpc.vpc_ec2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_ec2.id
  }

  tags = {
    Name = "rtb-ec2"
  }
}

resource "aws_subnet" "subnet_ec2" {
  vpc_id                  = aws_vpc.vpc_ec2.id
  cidr_block              = "10.0.0.0/28"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true # Atribui IP público automaticamente

  tags = {
    Name = "subnet-ec2"
  }
}

resource "aws_route_table_association" "rta_ec2" {
  subnet_id      = aws_subnet.subnet_ec2.id
  route_table_id = aws_route_table.rtb_ec2.id
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc_ec2.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Para maior segurança, substitua por seu IP específico (ex: "203.0.113.5/32")
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDDQDN5mGTMc8/Oj4L78c8OE9kPkB69Wcg4zEsmr6j5 matheus"
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = aws_key_pair.ssh_key.key_name

  # Usar o ID da subnet criada
  subnet_id              = aws_subnet.subnet_ec2.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id] # Associando o Security Group

  tags = {
    Name = "virtual-machine"
  }

  depends_on = [aws_vpc.vpc_ec2, aws_route_table_association.rta_ec2]
}

