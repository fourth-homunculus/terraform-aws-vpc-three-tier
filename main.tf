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

################################################
########## CREATING THE VPC RESOURCES ##########
################################################

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

################################################
########## CREATING THE EC2 RESOURCES ##########
################################################

#Create the security group for private EC2 instances (webserver)
resource "aws_security_group" "sg_prvapp_web" {
  name        = var.sg_prv_app_web_name
  description = var.sg_prv_app_description
  vpc_id      = aws_vpc.vpc_main.id

  ingress = [
    {
      description      = "Allow HTTP from VPC CIDR"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = [var.vpc_cidr_block]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "Allow HTTPS from VPC CIDR"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = [var.vpc_cidr_block]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "Allow outbound all traffic within the VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = [var.vpc_cidr_block]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "Allow outbound HTTP traffic to the internet"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "Allow outbound HTTPS traffic to the internet"      
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name       = var.sg_prv_app_web_name
    created_by = local.aws_caller_identity_arn
  }
}


# Get latest Amazon Linux AMI
data "aws_ami" "ami_amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


#Create the EC2 instance (webserver) in the private application subnet 1a - primary
resource "aws_instance" "ec2_prv_app_web_01" {
  ami                    = data.aws_ami.ami_amazon_linux_2.id
  instance_type          = var.ec2_prv_app_web_instance_type
  subnet_id              = aws_subnet.subnet_prv_app_1a.id
  vpc_security_group_ids = [aws_security_group.sg_prvapp_web.id]
  key_name               = var.ec2_key_pair
  iam_instance_profile   = aws_iam_instance_profile.profile_ec2_prv_app_web.name

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 50
    volume_type           = "gp2"
  }

  user_data = <<EOF
    #!/bin/bash
    sudo yum update -y
    sudo amazon-linux-extras enable epel
    sudo yum install epel-release -y
    sudo yum install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
    sudo systemctl start amazon-ssm-agent
    sudo systemctl enable amazon-ssm-agent
    sudo reboot
  EOF

  tags = {
    Name                 = var.ec2_prv_app_web_name_01
    created_by           = local.aws_caller_identity_arn
    ssm_managed_instance = var.tag_ec2_ssm_managed_instance
  }
}


#Create the EC2 instance (webserver) in the private application subnet 1b - secondary
resource "aws_instance" "ec2_prv_app_web_02" {
  ami                    = data.aws_ami.ami_amazon_linux_2.id
  instance_type          = var.ec2_prv_app_web_instance_type
  subnet_id              = aws_subnet.subnet_prv_app_1b.id
  vpc_security_group_ids = [aws_security_group.sg_prvapp_web.id]
  key_name               = var.ec2_key_pair
  iam_instance_profile   = aws_iam_instance_profile.profile_ec2_prv_app_web.name

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 50
    volume_type           = "gp2"
  }

  user_data = <<EOF
    #!/bin/bash
    sudo yum update -y
    sudo amazon-linux-extras enable epel
    sudo yum install epel-release -y
    sudo yum install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
    sudo systemctl start amazon-ssm-agent
    sudo systemctl enable amazon-ssm-agent
    sudo reboot
  EOF

  tags = {
    Name                 = var.ec2_prv_app_web_name_02
    created_by           = local.aws_caller_identity_arn
    ssm_managed_instance = var.tag_ec2_ssm_managed_instance
  }
}

#Create the security group for public ELB
resource "aws_security_group" "sg_pubelb_web" {
  name        = var.sg_pub_elb_web_name
  description = var.sg_pub_elb_web_description
  vpc_id      = aws_vpc.vpc_main.id

  ingress = [
    {
      description      = "Allow HTTP from public internet"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "Allow HTTPS from public internet"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "Allow outbound all traffic within the VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = [var.vpc_cidr_block]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name       = var.sg_pub_elb_web_name
    created_by = local.aws_caller_identity_arn
  }
}


#Create the ELB 
resource "aws_elb" "elb_pubelb_web" {
  name            = var.elb_pub_web_name
  subnets         = [aws_subnet.subnet_pub_1a.id, aws_subnet.subnet_pub_1b.id]
  security_groups = [aws_security_group.sg_pubelb_web.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = [aws_instance.ec2_prv_app_web_01.id, aws_instance.ec2_prv_app_web_02.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name       = var.elb_pub_web_name
    created_by = local.aws_caller_identity_arn
  }
}


#########################################################
########## AWS SSM SESSION MANAGER PERMISSIONS ##########
#########################################################

#Create the IAM policy that allows session manager connectivity
resource "aws_iam_policy" "policy_allow_aws_ssm_session_manager" {
  name        = var.policy_allow_aws_ssm_session_manager_name
  description = var.policy_allow_aws_ssm_session_manager_description

  policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "ssm:UpdateInstanceInformation",
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel"
          ],
          "Resource": "*"
        },
        {
          "Effect": "Allow",
          "Action": [
            "s3:GetEncryptionConfiguration"
          ],
          "Resource": "*"
        }
      ]
    }
  )

  tags = {
    Name       = var.policy_allow_aws_ssm_session_manager_name
    created_by = local.aws_caller_identity_arn
  }
}

#Create the data to be used as trust policy for the role
data "aws_iam_policy_document" "policy_ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

#Create the IAM role for the private EC2 instances (webserver)
resource "aws_iam_role" "role_ec2_prv_app_web" {
  name                = var.role_ec2_prv_app_web_name
  assume_role_policy  = data.aws_iam_policy_document.policy_ec2_assume_role.json
  managed_policy_arns = [aws_iam_policy.policy_allow_aws_ssm_session_manager.arn]

  tags = {
    Name       = var.role_ec2_prv_app_web_name
    created_by = local.aws_caller_identity_arn
  }
}

#Create the IAM instance profile for the private EC2 instances (webserver)
resource "aws_iam_instance_profile" "profile_ec2_prv_app_web" {
  name = var.profile_ec2_prv_app_web_name
  role = aws_iam_role.role_ec2_prv_app_web.name
}