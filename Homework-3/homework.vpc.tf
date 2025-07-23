
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "kaizen"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ca-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "my-subnet"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ca-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "my-subnet2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Homework-3-igw"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table" "main2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.main2.id
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "my_security_group"
  }
  
  ingress {
    description = "SSH froma anywhere"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }

ingress {
    description = "HTTP from anywhere"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "instance1" {
  ami           = "ami-0c0a551d0459e9d39"
  instance_type = "t2.micro"
  subnet_id     = "aws_subnet.subnet1.id"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data     = file("apache.sh")
  tags = {
    Name = "Ubuntu-Instance"
  }
}

resource "aws_instance" "instance2" {
  ami           = "ami-08379337a6fc559cd"
  instance_type = "t2.micro"
  subnet_id     = "aws_subnet.subnet2.id"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data     = file("apache.sh")
  tags = {
    Name = "Amazon-Instance"
  }
}