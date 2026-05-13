resource "aws_instance" "name" {
  ami = "ami-0a59ec92177ec3fad"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  tags = {
    Name = "test"
  }
  
}
resource "aws_s3_bucket" "name" {
    bucket = "kavya-unique-bucket"
  }

#in this 2 resources will create if we apply but we need only one
#so we can restrict her by giving command
#terraform plan -target=aws_s3_bucket.name -target=aws_instance.name for multiple targets
#target resource we use to apply