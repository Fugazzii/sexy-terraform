output "vpc_id" {
  description = "Main VPC ID"
  value       = aws_vpc.this.id
}

output "eip_id" {
  description = "Elastic ip for EC2 instance"
  value       = aws_eip.vm_ip.id
}

output "ec2_nic_id" {
  description = "Network interface for main EC2 instance"
  value       = aws_network_interface.ec2_nic.id
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[*].id
}
