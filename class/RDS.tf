resource "aws_db_subnet_group" "my-rds-subnet-group" {
  name = "my-rds-subnet-group"
  subnet_ids = [
    aws_subnet.my_pri_rds_sub1.id,
    aws_subnet.my_pri_rds_sub2.id
  ]
  tags = {
    "Name" = "my-rds-subnet-group"
  }
}

resource "aws_db_instance" "my_db" {
  allocated_storage     = 20
  max_allocated_storage = 50
  db_subnet_group_name  = aws_db_subnet_group.my-rds-subnet-group.name
  engine                = "mariadb"
  engine_version        = "10.5"
  instance_class        = "db.t3.small"
  identifier            = "my-maridb"
  username              = "root"
  db_name               = "my_db"
  port                  = "3306"
  password              = "Abcdefg12345678"
  multi_az              = true
  skip_final_snapshot   = true
  vpc_security_group_ids = [
    aws_security_group.my_rds_sg.id
  ]

  timeouts {
    create = "60m"
    delete = "2h"
  }
}
