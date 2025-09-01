output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc_ansys.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id, aws_subnet.public_subnet3.id ]
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id, aws_subnet.private_subnet3.id ]
}


