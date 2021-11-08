variable "aws_region" {
  description = "The AWS region to use"
  type        = string
  default     = "ap-southeast-1"
}

variable "vpc_name" {
  description = "The VPC Name tag"
  type        = string
  default     = "vpc-three-tier"
}

variable "vpc_cidr_block" {
  description = "The VPC CIDR block"
  type        = string
  default     = "10.0.0.0/24"
}

variable "main_rtb_name" {
  description = "The main route table Name tag"
  type        = string
  default     = "main-route-table"
}