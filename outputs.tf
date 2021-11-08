output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc_three_tier.id
}