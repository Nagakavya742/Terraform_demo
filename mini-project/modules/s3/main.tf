resource "aws_s3_bucket" "project" {
  bucket = var.bucket_name
  tags = {
    Name = var.bucket_name
  }
}