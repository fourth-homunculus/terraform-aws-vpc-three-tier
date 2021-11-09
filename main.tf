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

locals {
  aws_caller_identity_arn = data.aws_caller_identity.current.arn
}


#Get the user ARN of who invoked the creation of resources
data "aws_caller_identity" "current" {}


#Create the VPC
resource "aws_vpc" "vpc_main" {
  cidr_block = var.vpc_cidr_block

  tags = {
      Name       = var.vpc_name,
      created_by = local.aws_caller_identity_arn
  }
}


#Create the default route table
resource "aws_default_route_table" "rtb_main" {
  default_route_table_id = aws_vpc.vpc_main.default_route_table_id
  route = []

  tags = {
    Name       = var.rtb_main_name,
    created_by = local.aws_caller_identity_arn
  }
}


#Create the internet gateway for the VPC
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = var.vpc_igw_name,
    created_by = local.aws_caller_identity_arn
  }
}


#Create the route tables for public subnets: pub_1a, pub_1b
resource "aws_route_table" "rtb_pub_1a" {
  vpc_id = aws_vpc.vpc_main.id

  route = [
    {
      cidr_block = "0.0.0.0/0",
      gateway_id = aws_internet_gateway.vpc_igw.id,
      egress_only_gateway_id = "",
      carrier_gateway_id = "",
      destination_prefix_list_id = "",
      instance_id="",
      ipv6_cidr_block = "",
      local_gateway_id = "",
      nat_gateway_id = "",
      network_interface_id = "",
      transit_gateway_id = "",
      vpc_endpoint_id = "",
      vpc_peering_connection_id = ""
    }
  ]

  tags = {
    Name       = var.rtb_pub_1a_name,
    created_by = local.aws_caller_identity_arn
  }
}

resource "aws_route_table" "rtb_pub_1b" {
  vpc_id = aws_vpc.vpc_main.id

  route = [
    {
      cidr_block = "0.0.0.0/0",
      gateway_id = aws_internet_gateway.vpc_igw.id,
      egress_only_gateway_id = "",
      carrier_gateway_id = "",
      destination_prefix_list_id = "",
      instance_id="",
      ipv6_cidr_block = "",
      local_gateway_id = "",
      nat_gateway_id = "",
      network_interface_id = "",
      transit_gateway_id = "",
      vpc_endpoint_id = "",
      vpc_peering_connection_id = ""
    }
  ]

  tags = {
    Name       = var.rtb_pub_1b_name,
    created_by = local.aws_caller_identity_arn
  }
}


#Create the public subnets: pub_1a, pub_1b
resource "aws_subnet" "subnet_pub_1a" {
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = var.subnet_pub_1a_cidr
  availability_zone = var.availability_zone_1a

  tags = {
    Name       = var.subnet_pub_1a_name,
    created_by = local.aws_caller_identity_arn
  }
}

resource "aws_subnet" "subnet_pub_1b" {
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = var.subnet_pub_1b_cidr
  availability_zone = var.availability_zone_1b

  tags = {
    Name       = var.subnet_pub_1b_name,
    created_by = local.aws_caller_identity_arn
  }
}


#Create the route table association for public subnets: pub_1a, pub_1b
resource "aws_route_table_association" "rtbassoc_pub_1a" {
  subnet_id      = aws_subnet.subnet_pub_1a.id
  route_table_id = aws_route_table.rtb_pub_1a.id

  depends_on = [aws_route_table.rtb_pub_1a]
}

resource "aws_route_table_association" "rtbassoc_pub_1b" {
  subnet_id      = aws_subnet.subnet_pub_1b.id
  route_table_id = aws_route_table.rtb_pub_1b.id

  depends_on = [aws_route_table.rtb_pub_1b]
}


#Allocate 2 EIP's to be used for NAT Gateways
resource "aws_eip" "eip_natgw_pub_1a" {
  tags = {
    Name       = var.eip_natgw_pub_1a_name,
    created_by = local.aws_caller_identity_arn
  }
}

resource "aws_eip" "eip_natgw_pub_1b" {
  tags = {
    Name       = var.eip_natgw_pub_1b_name,
    created_by = local.aws_caller_identity_arn
  }  
}


#Create NAT Gateways to be used by private application subnets: prv_app_1a, prv_app_1b
resource "aws_nat_gateway" "natgw_pub_1a" {
  allocation_id = aws_eip.eip_natgw_pub_1a.allocation_id
  subnet_id     = aws_subnet.subnet_pub_1a.id

  tags = {
    Name = var.natgw_pub_1a_name,
    created_by = local.aws_caller_identity_arn
  }

  depends_on = [aws_subnet.subnet_pub_1a]
}

resource "aws_nat_gateway" "natgw_pub_1b" {
  allocation_id = aws_eip.eip_natgw_pub_1b.allocation_id
  subnet_id     = aws_subnet.subnet_pub_1b.id

  tags = {
    Name = var.natgw_pub_1b_name,
    created_by = local.aws_caller_identity_arn
  }

  depends_on = [aws_subnet.subnet_pub_1b]
}


#Create the route tables for private application subnets: prv_app_1a, prv_app_1b
resource "aws_route_table" "rtb_prv_app_1a" {
  vpc_id = aws_vpc.vpc_main.id

  route = [
    {
      cidr_block = "0.0.0.0/0",
      gateway_id = "",
      egress_only_gateway_id = "",
      carrier_gateway_id = "",
      destination_prefix_list_id = "",
      instance_id="",
      ipv6_cidr_block = "",
      local_gateway_id = "",
      nat_gateway_id = aws_nat_gateway.natgw_pub_1a.id,
      network_interface_id = "",
      transit_gateway_id = "",
      vpc_endpoint_id = "",
      vpc_peering_connection_id = ""
    }
  ]

  tags = {
    Name       = var.rtb_prv_app_1a_name,
    created_by = local.aws_caller_identity_arn
  }
}

resource "aws_route_table" "rtb_prv_app_1b" {
  vpc_id = aws_vpc.vpc_main.id

  route = [
    {
      cidr_block = "0.0.0.0/0",
      gateway_id = "",
      egress_only_gateway_id = "",
      carrier_gateway_id = "",
      destination_prefix_list_id = "",
      instance_id="",
      ipv6_cidr_block = "",
      local_gateway_id = "",
      nat_gateway_id = aws_nat_gateway.natgw_pub_1b.id,
      network_interface_id = "",
      transit_gateway_id = "",
      vpc_endpoint_id = "",
      vpc_peering_connection_id = ""
    }
  ]

  tags = {
    Name       = var.rtb_prv_app_1b_name,
    created_by = local.aws_caller_identity_arn
  }
}

#Create the private application subnets: prv_app_1a, prv_app_1b
resource "aws_subnet" "subnet_prv_app_1a" {
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = var.subnet_prv_app_1a_cidr
  availability_zone = var.availability_zone_1a

  tags = {
    Name       = var.subnet_prv_app_1a_name,
    created_by = local.aws_caller_identity_arn
  }
}

resource "aws_subnet" "subnet_prv_app_1b" {
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = var.subnet_prv_app_1b_cidr
  availability_zone = var.availability_zone_1b

  tags = {
    Name       = var.subnet_prv_app_1b_name,
    created_by = local.aws_caller_identity_arn
  }
}


#Create the route table association for private application subnets: prv_app_1a, prv_app_1b
resource "aws_route_table_association" "rtbassoc_prv_app_1a" {
  subnet_id      = aws_subnet.subnet_prv_app_1a.id
  route_table_id = aws_route_table.rtb_prv_app_1a.id

  depends_on = [aws_route_table.rtb_prv_app_1a]
}

resource "aws_route_table_association" "rtbassoc_prv_app_1b" {
  subnet_id      = aws_subnet.subnet_prv_app_1b.id
  route_table_id = aws_route_table.rtb_prv_app_1b.id

  depends_on = [aws_route_table.rtb_prv_app_1b]
}


#Create the route tables for private database subnets: prv_db_1a, prv_db_1b
resource "aws_route_table" "rtb_prv_db_1a" {
  vpc_id = aws_vpc.vpc_main.id
  route = []

  tags = {
    Name       = var.rtb_prv_db_1a_name,
    created_by = local.aws_caller_identity_arn
  }
}

resource "aws_route_table" "rtb_prv_db_1b" {
  vpc_id = aws_vpc.vpc_main.id
  route = []

  tags = {
    Name       = var.rtb_prv_db_1b_name,
    created_by = local.aws_caller_identity_arn
  }
}


#Create the private database subnets: prv_db_1a, prv_db_1b
resource "aws_subnet" "subnet_prv_db_1a" {
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = var.subnet_prv_db_1a_cidr
  availability_zone = var.availability_zone_1a

  tags = {
    Name       = var.subnet_prv_db_1a_name,
    created_by = local.aws_caller_identity_arn
  }
}

resource "aws_subnet" "subnet_prv_db_1b" {
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = var.subnet_prv_db_1b_cidr
  availability_zone = var.availability_zone_1b

  tags = {
    Name       = var.subnet_prv_db_1b_name,
    created_by = local.aws_caller_identity_arn
  }
}


#Create the route table association for private database subnets: prv_db_1a, prv_db_1b
resource "aws_route_table_association" "rtbassoc_prv_db_1a" {
  subnet_id      = aws_subnet.subnet_prv_db_1a.id
  route_table_id = aws_route_table.rtb_prv_db_1a.id

  depends_on = [aws_route_table.rtb_prv_db_1a]
}

resource "aws_route_table_association" "rtbassoc_prv_db_1b" {
  subnet_id      = aws_subnet.subnet_prv_db_1b.id
  route_table_id = aws_route_table.rtb_prv_db_1b.id

  depends_on = [aws_route_table.rtb_prv_db_1b]
}
