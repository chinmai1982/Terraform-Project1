#1.Create VPC

resource "aws_vpc" "chinu-test-vpc" {
  cidr_block = "10.0.0.0/16"  
}