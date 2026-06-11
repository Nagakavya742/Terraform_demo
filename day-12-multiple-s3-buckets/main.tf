resource "aws_s3_bucket" "test_buckets"{
  count = length(var.s3_bucket_name)
  bucket = var.s3_bucket_name[count.index]
  force_destroy = true
}