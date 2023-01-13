#2. create Internet gateway

resource "aws_internet_gateway" "igwtest" {
  vpc_id = aws_vpc.chinu-test-vpc.id

  
}