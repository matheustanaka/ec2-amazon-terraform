resource "aws_vpc" "vpc_ec2" {
  cidr_block       = "10.0.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name        = "vpc-${terraform.workspace}"
    Environment = var.environment
  }
}

resource "aws_subnet" "subnet_ec2_public_az_a" {
  vpc_id                  = aws_vpc.vpc_ec2.id
  cidr_block              = "10.0.0.0/28"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "subnet-${terraform.workspace}"
    Environment = var.environment
  }
}

resource "aws_subnet" "subnet_ec2_public_az_b" {
  vpc_id                  = aws_vpc.vpc_ec2.id
  cidr_block              = "10.0.0.16/28"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name        = "subnet-${terraform.workspace}"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "igw_ec2" {
  vpc_id = aws_vpc.vpc_ec2.id # Definindo a vpc que terá acesso a internet

  tags = {
    Name = "internet-gateway-${terraform.workspace}"
  }
}

resource "aws_route_table" "rtb_ec2" {
  vpc_id = aws_vpc.vpc_ec2.id

  route {
    cidr_block = "0.0.0.0/0" # Significa que qualquer IP local ou qualquer pessoa na internet pode acessar
    # qualquer ipv4 pode acessar por conta do /0, se fosse ipv6 seria ::/0

    gateway_id = aws_internet_gateway.igw_ec2.id
  }

  tags = {
    Name        = "route-table-${terraform.workspace}"
    Environment = var.environment
  }
}

# Linkando a subnet e a tabela de roteamento 
resource "aws_route_table_association" "rta_ec2" {
  for_each = {
    "subnet_a" : aws_subnet.subnet_ec2_public_az_a.id,
    "subnet_b" : aws_subnet.subnet_ec2_public_az_b.id
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.rtb_ec2.id
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_${terraform.workspace}"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc_ec2.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "allow-ssh-${terraform.workspace}"
    Environment = var.environment
  }
}
