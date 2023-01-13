





#4. create a subnet

resource "aws_subnet" "chinu-test-subnet" {
  vpc_id     = aws_vpc.chinu-test-vpc.id

  cidr_block = "10.0.0.0/24"
  availability_zone = "us-west-1a"
  tags = {
    Name = "testsubnet"
  }
}

#5. associate subnet with rout table

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.chinu-test-subnet.id
  route_table_id = aws_route_table.chinu-test-rout-table.id
}

#6. Create security group that allow port 22,80,443

resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.chinu-test-vpc.id

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    ingress {
    description      = "HTTPS"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "allow_web"
  }
}

#7. Create a network interface with an IP in the subnet that was created in step 4

resource "aws_network_interface" "chinu-test-nic" {
  subnet_id       = aws_subnet.chinu-test-subnet.id
  private_ips     = ["10.0.0.50"]
  security_groups = [aws_security_group.allow_web.id]

}

#8. Assign an elastic IP to the network Interface created in step 7

resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.chinu-test-nic.id
  associate_with_private_ip = "10.0.0.50"
  depends_on = [
    aws_internet_gateway.igwtest
  ]
}

#9. Create Linux server

resource "aws_instance" "My-EC2-Server" {
  ami           = var.amiId
  instance_type = var.instanceType
  subnet_id = aws_subnet.chinu-test-subnet.id
  availability_zone = "us-west-1a"
        tags = {
        Name = "LinuxServer"
    }
  }