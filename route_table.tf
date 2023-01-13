#3. create Router Table

resource "aws_route_table" "chinu-test-rout-table" {
  vpc_id = aws_vpc.chinu-test-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igwtest.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.igwtest.id
  }

  tags = {
    Name = "testrout"
  }
}