output "ec2" {
  # value = aws_instance.ec2[var.count_instance]
  value = [for instance in aws_instance.ec2 : instance.id]
}
