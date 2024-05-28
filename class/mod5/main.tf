resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    "Name" = "my_vpc"
  }
}

resource "aws_subnet" "my_pub_sub1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "my_pub_sub1"
  }
}

resource "aws_subnet" "my_pub_sub2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "my_pub_sub2"
  }
}


resource "aws_subnet" "my_pri_sub1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "my_pri_sub1"
  }
}

resource "aws_subnet" "my_pri_sub2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"
  tags = {
    "Name" = "my_pri_sub2"
  }
}

resource "aws_subnet" "my_pri_rds_sub2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1c"
  tags = {
    "Name" = "my_pri_rds_sub2"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    "Name" = "my_igw"
  }
}

resource "aws_route_table" "my_pub_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    "Name" = "my_pub_rt"
  }
}

resource "aws_route_table_association" "my_pub_rt_assoication1" {
  subnet_id      = aws_subnet.my_pub_sub1.id
  route_table_id = aws_route_table.my_pub_rt.id
}

resource "aws_route_table_association" "my_pub_rt_assoication2" {
  subnet_id      = aws_subnet.my_pub_sub2.id
  route_table_id = aws_route_table.my_pub_rt.id
}


resource "aws_eip" "my_eip1" {
  tags = {
    "Name" = "my_eip1"
  }
}

resource "aws_nat_gateway" "my_nat1" {
  allocation_id = aws_eip.my_eip1.id
  subnet_id     = aws_subnet.my_pub_sub1.id
  depends_on    = [aws_internet_gateway.my_igw]

  tags = {
    "Name" = "my_nat1"
  }
}

resource "aws_route_table" "my_pri_rt1" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my_nat1.id
  }
  tags = {
    "Name" = "my_pri_rt1"
  }
}

resource "aws_route_table_association" "my_pri_rt_assoication1" {
  subnet_id      = aws_subnet.my_pri_sub1.id
  route_table_id = aws_route_table.my_pri_rt1.id
}


resource "aws_eip" "my_eip2" {
  tags = {
    "Name" = "my_eip2"
  }
}

resource "aws_nat_gateway" "my_nat2" {
  allocation_id = aws_eip.my_eip2.id
  subnet_id     = aws_subnet.my_pub_sub2.id
  depends_on    = [aws_internet_gateway.my_igw]

  tags = {
    "Name" = "my_nat2"
  }
}

resource "aws_route_table" "my_pri_rt2" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my_nat2.id
  }
  tags = {
    "Name" = "my_pri_rt2"
  }
}

resource "aws_route_table_association" "my_pri_rt_assoication2" {
  subnet_id      = aws_subnet.my_pri_sub2.id
  route_table_id = aws_route_table.my_pri_rt2.id
}
