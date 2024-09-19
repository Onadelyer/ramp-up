output "instance_id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.spg_api.id
}

output "public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.spg_api.public_ip
}

output "private_ip" {
  description = "The private IP address of the EC2 instance."
  value       = aws_instance.spg_api.private_ip
}
