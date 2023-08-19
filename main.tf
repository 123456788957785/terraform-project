#this file consists of code for instances and sg
provider "aws" {
region = "us-west-1"
access_key = ""
secret_key = ""
}

resource "aws_instance" "one" {
  ami             = "ami-019f33d94f416763f"
  instance_type   = "t2.micro"
  key_name        = "vinay"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-west-1"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by vinay server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-019f33d94f416763f"
  instance_type   = "t2.micro"
  key_name        = "vinay"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-west-1"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte by vinay server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-2"
  }
}

resource "aws_instance" "three" {
  ami             = "ami-019f33d94f416763f"
  instance_type   = "t2.micro"
  key_name        = "vinay"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-west-1"
  tags = {
    Name = "app-server-1"
  }
}

resource "aws_instance" "four" {
  ami             = "ami-019f33d94f416763f"
  instance_type   = "t2.micro"
  key_name        = "vinay"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-west-1"
  tags = {
    Name = "app-server-2"
  }
}

resource "aws_security_group" "five" {
  name = "elb-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "six" {
  bucket = "terra123"
}

resource "aws_iam_user" "seven" {
for_each = var.user_names
name = each.value
}

variable "user_names" {
description = "*"
type = set(string)
default = ["user1", "user2", "user3", "user4"]
}

resource "aws_ebs_volume" "eight" {
 availability_zone = "us-west-1"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
