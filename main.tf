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

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  key_name = "ssh_key"

  tags = {
    Name = "virtual-machine"
  }

  # Referência ao Security Group que permite todo o tráfego
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}

provider "aws" {
  profile = "matheus"
  region  = "us-east-2"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDDQDN5mGTMc8/Oj4L78c8OE9kPkB69Wcg4zEsmr6j5 matheus"
}

# Configuração de exemplo para o Security Group (permitindo todo o tráfego, como mencionado)
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow all traffic for testing purposes"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

