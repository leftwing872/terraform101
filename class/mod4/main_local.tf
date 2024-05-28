locals {
 ami  = "ami-0bb84b8ffd87024d8"
 type = "t3.micro"
 tags = {
   Name = "My EC2 instance"
   Env  = "Dev"
 }
 subnet = "subnet-0a50c9cff2bf30ba1"
}

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.4.20240513.0-kernel-6.1-x86_64"]
  }

  filter {
    name   = "root-device-type" #you have to change underscore to hyphe.
    values = ["ebs"]
  }
}

output "haha" {
    value = data.aws_ami.al2023
}
 
resource "aws_instance" "myec2" {
 ami           = data.aws_ami.al2023.id
 instance_type = local.type
 tags          = local.tags
 subnet_id = local.subnet
}