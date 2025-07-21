
resource "aws_instance" "web1" {
  region = "us-west-2"
  ami           = "ami-0ec1bf4a8f92e7bd1"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0378f895f253bfde0"
  user_data     = file("apache.sh")
  tags = {
    Name = "web-1"
  }
}
resource "aws_instance" "web2" {
  region = "us-west-2"
  ami           = "ami-0ec1bf4a8f92e7bd1"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0ea7a927c24ae38cd"
  user_data     = file("apache.sh")
  tags = {
    Name = "web-2"
  }
}

resource "aws_instance" "web3" {
  region = "us-west-2"
  ami           = "ami-0ec1bf4a8f92e7bd1"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0ea7a927c24ae38cd"
  user_data     = file("apache.sh")
  tags = {
    Name = "web-3"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
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

ingress {
    description = "MySQL from anywhere"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
}
}

 



