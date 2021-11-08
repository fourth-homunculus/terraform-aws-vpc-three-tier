#Some Terraform and AWS stuff
terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  required_version = ">= 0.14.9"

}

provider "aws" {
  region  = var.aws_region
}

#Get the user_id of the caller
data "aws_caller_identity" "current" {}

#Create the VPC
resource "aws_vpc" "vpc_three_tier" {

  cidr_block = var.vpc_cidr_block

  tags = {
      Name       = var.vpc_name,
      created_by = data.aws_caller_identity.current.arn
  }
}

#Create the default route table
resource "aws_default_route_table" "main_rtb" {

  default_route_table_id = aws_vpc.vpc_three_tier.default_route_table_id
  route = []

  tags = {
    Name = var.main_rtb_name
  }
}