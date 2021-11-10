output "vpc-id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc_main.id
}

output "vpc-igw-id" {
  description = "The ID of the VPC IGW"
  value       = aws_internet_gateway.vpc_igw.id
}

output "rtb-pub_1a-id" {
  description = "The ID of the route table for public subnet 1a"
  value       = aws_route_table.rtb_pub_1a.id
}

output "rtb-pub_1b-id" {
  description = "The ID of the route table for public subnet 1b"
  value       = aws_route_table.rtb_pub_1b.id
}

output "rtb-prv_app_1a-id" {
  description = "The ID of the route table for private application subnet 1a"
  value       = aws_route_table.rtb_prv_app_1a.id
}

output "rtb-prv_app_1b-id" {
  description = "The ID of the route table for private application subnet 1b"
  value       = aws_route_table.rtb_prv_app_1b.id
}

output "rtb-prv_db_1a-id" {
  description = "The ID of the route table for private database subnet 1a"
  value       = aws_route_table.rtb_prv_db_1a.id
}

output "rtb-prv_db_1b-id" {
  description = "The ID of the route table for private database subnet 1b"
  value       = aws_route_table.rtb_prv_db_1b.id
}

output "subnet-pub_1a-id" {
  description = "The ID of the public subnet 1a"
  value       = aws_subnet.subnet_pub_1a.id
}

output "subnet-pub_1b-id" {
  description = "The ID of the public subnet 1b"
  value       = aws_subnet.subnet_pub_1b.id
}

output "subnet-prv_app_1a-id" {
  description = "The ID of the private application subnet 1a"
  value       = aws_subnet.subnet_prv_app_1a.id
}

output "subnet-prv_app_1b-id" {
  description = "The ID of the private application subnet 1b"
  value       = aws_subnet.subnet_prv_app_1b.id
}

output "subnet-prv_db_1a-id" {
  description = "The ID of the private database subnet 1a"
  value       = aws_subnet.subnet_prv_db_1a.id
}

output "subnet-prv_db_1b-id" {
  description = "The ID of the private database subnet 1b"
  value       = aws_subnet.subnet_prv_db_1b.id
}

output "eip-nat-pub_1a-public_ip" {
  description = "The EIP for the NAT Gateway in public subnet 1a"
  value       = aws_eip.eip_natgw_pub_1a.public_ip
}

output "eip-nat-pub_1b-public_ip" {
  description = "The EIP for the NAT Gateway in public subnet 1b"
  value       = aws_eip.eip_natgw_pub_1b.public_ip
}

output "sg-prv_app-web-id" {
  description = "The ID of the security group for the private EC2 instances (webserver)"
  value       = aws_security_group.sg_prvapp_web.id
}

output "elb-pub-web-dns_name" {
  description = "The DNS name of the public ELB (webserver)"
  value       = aws_elb.elb_pubelb_web.dns_name
}

output "policy-allow_ssm-session_manager-arn"  {
  description = "The ARN of the IAM policy for role to be used by private EC2 instances (webserver)"
  value       = aws_iam_policy.policy_allow_aws_ssm_session_manager.arn
}

output role-ec2_prv_app-web-arn {
  description = "The ARN of the IAM role for the private EC2 instances (webserver)"
  value       = aws_iam_role.role_ec2_prv_app_web.arn
}