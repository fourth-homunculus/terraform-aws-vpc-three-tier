output "vpc-id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc_main.id
}

output "vpc-igw-id" {
  description = "ID of the VPC IGW"
  value       = aws_internet_gateway.vpc_igw.id
}

output "rtb-pub_1a-id" {
  description = "ID of the route table for public subnet 1a"
  value       = aws_route_table.rtb_pub_1a.id
}

output "rtb-pub_1b-id" {
  description = "ID of the route table for public subnet 1b"
  value       = aws_route_table.rtb_pub_1b.id
}

output "rtb-prv_app_1a-id" {
  description = "ID of the route table for private application subnet 1a"
  value       = aws_route_table.rtb_prv_app_1a.id
}

output "rtb-prv_app_1b-id" {
  description = "ID of the route table for private application subnet 1b"
  value       = aws_route_table.rtb_prv_app_1b.id
}

output "rtb-prv_db_1a-id" {
  description = "ID of the route table for private database subnet 1a"
  value       = aws_route_table.rtb_prv_db_1a.id
}

output "rtb-prv_db_1b-id" {
  description = "ID of the route table for private database subnet 1b"
  value       = aws_route_table.rtb_prv_db_1b.id
}

output "subnet-pub_1a-id" {
  description = "ID of the public subnet 1a"
  value       = aws_subnet.subnet_pub_1a.id
}

output "subnet-pub_1b-id" {
  description = "ID of the public subnet 1b"
  value       = aws_subnet.subnet_pub_1b.id
}

output "subnet-prv_app_1a-id" {
  description = "ID of the private application subnet 1a"
  value       = aws_subnet.subnet_prv_app_1a.id
}

output "subnet-prv_app_1b-id" {
  description = "ID of the private application subnet 1b"
  value       = aws_subnet.subnet_prv_app_1b.id
}

output "subnet-prv_db_1a-id" {
  description = "ID of the private database subnet 1a"
  value       = aws_subnet.subnet_prv_db_1a.id
}

output "subnet-prv_db_1b-id" {
  description = "ID of the private database subnet 1b"
  value       = aws_subnet.subnet_prv_db_1b.id
}

output "eip-nat-pub_1a" {
  description = "The EIP for the NAT Gateway in public subnet 1a"
  value       = aws_eip.eip_natgw_pub_1a.public_ip
}

output "eip-nat-pub_1b" {
  description = "The EIP for the NAT Gateway in public subnet 1b"
  value       = aws_eip.eip_natgw_pub_1b.public_ip
}