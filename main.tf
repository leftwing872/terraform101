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
  ami           = var.ami_id
  instance_type = "t3.micro"
  key_name = var.key
  vpc_security_group_ids = [aws_security_group.app_server.id]
  tags = {
    Name = var.instance_name
    Type = "ec2"
  }
}

# Security Group

resource "aws_security_group" "app_server" {
    name        = "sg_app_server"
    description = "Allow TLS inbound traffic"
    
    vpc_id  = var.vpc_id
    

    # Egress All
    egress {
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    
}

# Security Group Rule

resource "aws_security_group_rule" "app_server_01" {
    type = "ingress"
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["10.80.84.96/27", "0.0.0.0/0"]
    security_group_id = aws_security_group.app_server.id
    description = "Ingress app_server ssh"
}


