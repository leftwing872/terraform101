resource "aws_security_group" "my_alb_sg" {
  name        = "my_alb_sg"
  description = "Allow HTTP from Client"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    "Name" = "my_alb_sg"
  }
}

resource "aws_security_group_rule" "my_alb_sg_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.my_alb_sg.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "my_alb_sg_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.my_alb_sg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_security_group" "my_ec2_sg" {
  name        = "my_ec2_sg"
  description = "Allow HTTP from EC2"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    "Name" = "my_ec2_sg"
  }
}

resource "aws_security_group_rule" "my_ec2_sg_inbound" {
  type                     = "ingress"
  security_group_id        = aws_security_group.my_ec2_sg.id
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.my_alb_sg.id
}

resource "aws_security_group_rule" "my_ec2_sg_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.my_ec2_sg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_security_group" "my_rds_sg" {
  name        = "my_rds_sg"
  description = "Allow HTTP from EC2"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    "Name" = "my_rds_sg"
  }
}

resource "aws_security_group_rule" "my_rds_sg_inbound" {
  type                     = "ingress"
  security_group_id        = aws_security_group.my_rds_sg.id
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.my_ec2_sg.id
}

resource "aws_security_group_rule" "my_rds_sg_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.my_rds_sg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

