resource "aws_instance" "ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  key_name = aws_key_pair.ssh_key.key_name

  vpc_security_group_ids = [var.security_group_allow_ssh] # Associando o Security Group

  subnet_id = var.environment == "development-environment" ? var.subnet_ec2_public_az_a : var.subnet_ec2_public_az_b

  tags = {
    Name        = var.tag_name
    Environment = var.environment
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "ec2_ssh_key_${terraform.workspace}"
  public_key = var.public_key
}
