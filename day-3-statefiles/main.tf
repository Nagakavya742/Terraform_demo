resource "aws_instance" "name" {
  instance_type = var.instance_type
  ami = var.ami_id
  tags = {
    Name = "test"
  }
  
}

resource "aws_s3_bucket" "name" {
  bucket = "kavya-unique-bucket"
}

resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  
}