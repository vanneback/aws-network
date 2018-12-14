resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags {
    Name = "${var.project}-vpc"
    Project = "${var.project}"
  }
}

resource "aws_subnet" "private_sn" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8 ,1)}"
  availability_zone = "${var.AZ}"
  tags {
    Name = "${var.project}-private-subnet"
    Project = "${var.project}"
  }
}

resource "aws_subnet" "public_sn" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8 ,2)}"
  availability_zone = "${var.AZ}"
  map_public_ip_on_launch = true
  tags {
    Name = "${var.project}-public-subnet"
    Project = "${var.project}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.project}-igw"
    Project = "${var.project}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "10.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags {
    Name = "${var.project}-public-rt"
    Project = "${var.project}"
  }
}

resource "aws_route_table_association" "public_rta" {
  subnet_id       = "${aws_subnet.public_sn.id}"
  route_table_id  = "${aws_route_table.public_rt.id}"
}

resource "aws_security_group" "public_sg" {
  vpc_id        = "${aws_vpc.vpc.id}"
  name          = "${var.project}-public-sg"
  tags { 
    Name        = "${var.project}-public-sg"
    Project     = "${var.project}"
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${aws_subnet.private_sn.cidr_block}"]
  }
}

resource "aws_security_group" "private_sg" {
  vpc_id        = "${aws_vpc.vpc.id}"
  name          = "${var.project}-private-sg"
  tags { 
    Name        = "${var.project}-private-sg"
    Project     = "${var.project}"
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["${aws_subnet.public_sn.cidr_block}"]
  }
   ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["${aws_subnet.public_sn.cidr_block}"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["${aws_subnet.public_sn.cidr_block}"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["${aws_subnet.public_sn.cidr_block}"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["${aws_subnet.public_sn.cidr_block}"]
  }
}


resource "aws_key_pair" "default_key_pair" {
  key_name = "aws-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDhwS+bqPOE+teJzdbLJDggxuU3rh8z7Kzt7pZ1uvv7+k35ewTDasZwR41VDX13ixW9hze0I+ajs1ZGx5bz8wFikLCTySdo21J864WhlfGE4/nrYTHgEWemi9sX9R5zcwuFMvCsIbZpipAtyJpuJKzOqm8BPSjUPydy6BiZezClVdOxwbKLGOaJHBGOzA7wah3U8nhOzq+4aGAIR74qcOUQEcR0dTgYlMYk0M16auJO/ZLJ7JQp7x0UncpU5rvXPT026lBW6QVSooGRfG0x2tx0L7sn5pKHKMgYDVmawTPwcNV3Ca5Gbttx1fzwXQiQu1HVGdqQx4NOBqfyrYu90eR5 emil@emil-XPS-13-9370"
}   
