output "vpc_id" {
  description = "Main VPC ID"
  value = aws_vpc.this.id
}