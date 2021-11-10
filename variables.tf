variable "aws_region" {
  description = "The AWS region to use"
  type        = string
  default     = "ap-southeast-1"
}

variable "availability_zone_1a" {
  description = "The availability zone for 1a"
  type = string
  default = "ap-southeast-1a"
}

variable "availability_zone_1b" {
  description = "The availability zone for 1a"
  type = string
  default = "ap-southeast-1b"
}

variable "vpc_name" {
  description = "The VPC Name tag"
  type        = string
  default     = "vpc-three_tier"
}

variable "vpc_cidr_block" {
  description = "The VPC CIDR block"
  type        = string
  default     = "10.0.0.0/24"
}

variable "rtb_main_name" {
  description = "The main route table Name tag"
  type        = string
  default     = "rtb-three_tier-main"
}

variable "vpc_igw_name" {
  description = "The main route table Name tag"
  type        = string
  default     = "igw-three_tier"
}

variable "rtb_pub_1a_name" {
  description = "The route table Name tag for public subnet 1a"
  type        = string
  default     = "rtb-three_tier-pub_1a"
}

variable "rtb_pub_1b_name" {
  description = "The route table Name tag for public subnet 1b"
  type        = string
  default     = "rtb-three_tier-pub_1b"
}

variable "rtb_prv_app_1a_name" {
  description = "The route table Name tag for private application subnet 1a"
  type        = string
  default     = "rtb-three_tier-prv_app_1a"
}

variable "rtb_prv_app_1b_name" {
  description = "The route table Name tag for private application subnet 1b"
  type        = string
  default     = "rtb-three_tier-prv_app_1b"
}

variable "rtb_prv_db_1a_name" {
  description = "The route table Name tag for private database subnet 1a"
  type        = string
  default     = "rtb-three_tier-prv_db_1a"
}

variable "rtb_prv_db_1b_name" {
  description = "The route table Name tag for private database subnet 1a"
  type        = string
  default     = "rtb-three_tier-prv_db_1b"
}

variable "subnet_pub_1a_name" {
  description = "The subnet Name tag for public subnet 1a"
  type        = string
  default     = "subnet-three_tier-pub_1a"
}
variable "subnet_pub_1b_name" {
  description = "The subnet Name tag for public subnet 1b"
  type        = string
  default     = "subnet-three_tier-pub_1b"
}

variable "subnet_prv_app_1a_name" {
  description = "The subnet Name tag for private application subnet 1a"
  type        = string
  default     = "subnet-three_tier-prv_app_1a"
}
variable "subnet_prv_app_1b_name" {
  description = "The subnet Name tag for private application subnet 1b"
  type        = string
  default     = "subnet-three_tier-prv_app_1b"
}

variable "subnet_prv_db_1a_name" {
  description = "The subnet Name tag for private database subnet 1a"
  type        = string
  default     = "subnet-three_tier-prv_db_1a"
}

variable "subnet_prv_db_1b_name" {
  description = "The subnet Name tag for private database subnet 1b"
  type        = string
  default     = "subnet-three_tier-prv_db_1b"
}

variable "subnet_pub_1a_cidr" {
  description = "The CIDR block for public subnet 1a"
  type        = string
  default     = "10.0.0.0/27"
}
variable "subnet_pub_1b_cidr" {
  description = "The CIDR block for public subnet 1b"
  type        = string
  default     = "10.0.0.32/27"
}

variable "subnet_prv_app_1a_cidr" {
  description = "The CIDR block for private application subnet 1a"
  type        = string
  default     = "10.0.0.64/26"
}
variable "subnet_prv_app_1b_cidr" {
  description = "The CIDR block for private application subnet 1b"
  type        = string
  default     = "10.0.0.128/26"
}

variable "subnet_prv_db_1a_cidr" {
  description = "The CIDR block for private database subnet 1a"
  type        = string
  default     = "10.0.0.192/27"
}
variable "subnet_prv_db_1b_cidr" {
  description = "The CIDR block for private database subnet 1b"
  type        = string
  default     = "10.0.0.224/27"
}

variable "eip_natgw_pub_1a_name" {
  description = "The EIP Name tag for NAT Gateway in public subnet 1a"
  type        = string
  default     = "eip--three_tier-natgw-pub_1a"
}

variable "eip_natgw_pub_1b_name" {
  description = "The EIP Name tag for NAT Gateway in public subnet 1b"
  type        = string
  default     = "eip-three_tier-natgw-pub_1b"
}

variable "natgw_pub_1a_name" {
  description = "The EIP Name tag for NAT Gateway in public subnet 1b"
  type        = string
  default     = "natgw-three_tier-pub_1a"
}

variable "natgw_pub_1b_name" {
  description = "The EIP Name tag for NAT Gateway in public subnet 1b"
  type        = string
  default     = "natgw-three_tier-pub_1b"
}

variable "sg_prv_app_web_name" {
  description = "The security group Name tag for the private EC2 instances (webserver)"
  type        = string
  default     = "secgrp-three_tier-prv_app-web"
}

variable "sg_prv_app_description" {
  description = "The description of the security group for the private application EC2 instances (webserver)"
  type        = string
  default     = "Security group for private application EC2 instances (webserver)"
}

variable "ec2_prv_app_web_instance_type" {
  description = "The instance type for the private EC2 instances (webserver)"
  type        = string
  default     = "t2.micro"
}

variable "ec2_key_pair" {
  description = "The key pair for the EC2 instances"
  type        = string
  default     = "kp-terraform-aws-dev"
}

variable "ec2_prv_app_web_name_01" {
  description = "The Name tag for the private EC2 instances (webserver) - primary"
  type        = string
  default     = "three_tier-prv_app-web_01"
}

variable "ec2_prv_app_web_name_02" {
  description = "The Name tag for the private EC2 instances (webserver) - secondary"
  type        = string
  default     = "three_tier-prv_app-web_02"
}

variable "tag_ec2_ssm_managed_instance" {
  description = "The tag to identify if the EC2 instance is SSM enabled"
  type        = string
  default     = "true"
}

variable "sg_pub_elb_web_name" {
  description = "The security group Name tag for the public ELB (webserver)"
  type        = string
  default     = "secgrp-three_tier-pub_elb-web"
}

variable "sg_pub_elb_web_description" {
  description = "The description of the security group for the public ELB (webserver)"
  type        = string
  default     = "Security group for public ELB (webserver)"
}

variable "elb_pub_web_name" {
  description = "The Name tag for the public ELB (webserver)"
  type        = string
  default     = "elb-three-tier-pub-web"
}

variable "profile_ec2_prv_app_web_name" {
  description = "The name of the instance profile for the private EC2 instances (webserver)"
  type        = string
  default     = "profile_ec2_prv_app_web"
}

variable "role_ec2_prv_app_web_name" {
  description = "The name of the IAM role for the private EC2 instances (webserver)"
  type        = string
  default     = "ec2-prv_app-web-role"
}

variable "policy_allow_aws_ssm_session_manager_name" {
  description = "The name of the IAM policy for role to be used by private EC2 instances (webserver)"
  type        = string
  default     = "allow-aws_ssm-session_manager-policy"
}

variable "policy_allow_aws_ssm_session_manager_description" {
  description = "The description of the IAM policy for role to be used by private EC2 instances (webserver)"
  type        = string
  default     = "Allows AWS SSM Session Manager"
}

