resource "aws_instance" "name" {
  instance_type = var.instance_type
  ami = var.ami
  tags = {
    Name = "test"
  }
  depends_on =[aws_s3_bucket.name]
}

resource "aws_s3_bucket" "name" {
  bucket = "kavya-unique-bucket"
}
