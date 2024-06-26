terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "ap-northeast-2"
}

resource "aws_instance" "app_server" {
  count = var.number_example
  ami           ="ami-0e01e66dacaf1454d"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.app_server_sg.id]
  # tags = {
  #   Name = "AppServer1"
  #   Type = "ec2"
  # }
  
  #tags = var.map_example
  tags = local.tags_merge
}

locals {
  stage_tags = {
    Name = "AppServer1"
    Type = "ec2"
    key1 = "key1"
  }
  tags_merge = merge(var.map_example, local.stage_tags)
}

# Security Group
resource "aws_security_group" "app_server_sg" {
    name        = "sg_app_server"
    description = "Allow TLS inbound traffic"
    
    # Egress All
    egress {
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
}

# Security Group Rule
resource "aws_security_group_rule" "app_server_sg_ingress1" {
    type = "ingress"
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["10.80.84.96/27", "1.2.3.0/24"]
    security_group_id = aws_security_group.app_server_sg.id
    description = "Ingress app_server ssh"
}

module "ec2_instance" {
  source = "./modules/ec2"
  region = "ap-northeast-2"
  ami_id ="ami-0e01e66dacaf1454d"
  instance_type = "t3.micro"
  key_name = "YOUR_KEY_PAIR"
  instance_count = 1
  subnet_ids = ["subnet-071de07b184a6f908", "subnet-0894f2b01c7fc7b6f"]
  tags = local.tags_merge
  name = "test"
  environment = "dev"
  owner = "yourname"
  cost_center = "rnd"
  application = "example_frontend"
  security_group_ids = [aws_security_group.app_server_sg.id]
}


# module "consul" {
# 	source = "app.terraform.io/example-corp/k8s-cluster/azurerm"
#    	version = "1.1.0"
# }