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
  default     = "eip-natgw-pub_1a"
}

variable "eip_natgw_pub_1b_name" {
  description = "The EIP Name tag for NAT Gateway in public subnet 1b"
  type        = string
  default     = "eip-natgw-pub_1b"
}

variable "natgw_pub_1a_name" {
  description = "The EIP Name tag for NAT Gateway in public subnet 1b"
  type        = string
  default     = "natgw-pub_1a"
}

variable "natgw_pub_1b_name" {
  description = "The EIP Name tag for NAT Gateway in public subnet 1b"
  type        = string
  default     = "natgw-pub_1b"
}