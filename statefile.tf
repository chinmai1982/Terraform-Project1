terraform {
  backend "s3" {
    bucket = "terraform-test-bucket-chinu"
    key    = "ec2.tfvars"
    region = "us-west-1"
  }
}