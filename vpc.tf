provider "aws" {
  region = "us-west-2"
  default_tags {
    tags = {
      owner = "kk"
      github_profile = "url"
      udemy_profile = "url" 
      about_me = "url"
      youtube_profile = "url"
      buy_me_a_coffee = "url"
    }
  }
} 
########################### VPC ###########################
resource "aws_vpc" "kk-sbx-vpc" {
  cidr_block       = "10.30.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "kk-sbx-vpc"
    env  = "kk-sbx"
    owner   = "kk"
    project = "kk-network-stack"
  }
}
########################### SUBNET ###########################
resource "aws_subnet" "kk-sbx-sb-app" {
  vpc_id = aws_vpc.kk-sbx-vpc.id
  cidr_block = "10.30.0.0/20"
  tags = {
    Name = "kk-sbx-sb-app"
  }
}
resource "aws_subnet" "kk-sbx-sb-db" {
  vpc_id     = aws_vpc.kk-sbx-vpc.id
  cidr_block = "10.30.16.0/20"
  tags = {
    Name = "kk-sbx-sb-db"
  }
}
########################### SG ###########################
resource "aws_security_group" "kk-sbx-sg-ssh" {
  name = "kk-sbx-sg-ssh"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.kk-sbx-vpc.id
  ingress {
    description      = "For Admin purpose"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "kk-sbx-sg-ssh"
  }
}
resource "aws_security_group" "kk-sbx-sg-db" {
  name = "kk-sbx-sg-db"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.kk-sbx-vpc.id
  ingress {
    description      = "For Admin purpose"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "kk-sbx-sg-db"
  }
}
########################### IGW ###########################
resource "aws_internet_gateway" "kk-sbx-igw" {
  vpc_id = aws_vpc.kk-sbx-vpc.id

  tags = {
    Name = "kk-sbx-igw"
  }
}
########################### Routing Table & Subnet Association ###########################
resource "aws_route_table" "kk-sbx-rt" {
  vpc_id = aws_vpc.kk-sbx-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    #ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.kk-sbx-igw.id
  }

  tags = {
    Name = "kk-sbx-rt"
  }
}
resource "aws_route_table_association" "kksbxrt-kksbxsbapp" {
  subnet_id      = aws_subnet.kk-sbx-sb-app.id
  route_table_id = aws_route_table.kk-sbx-rt.id
}




  
  
