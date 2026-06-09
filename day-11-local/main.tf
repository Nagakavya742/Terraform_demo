locals {
  bucket-name = "${var.layer}-${var.env}-bucket-unique"
  region = "us-east-1"
  # provider = aws.Oregon
}

resource "aws_s3_bucket" "demo"{
  #bucket = "web-unique-bucket"
  #bucket = "${var.layer}-${var.env}-bucket-unique"
  bucket = local.bucket-name
  region = local.region
  # provider = [local.provider]
  tags = {
    Name = local.bucket-name
    Environment = var.env
  }
}



# locals {
#   region = "us-east-1"
#   instance-type = "t2.micro"
#   # provider = aws.Oregon
# }

# resource "aws_instance" "demo"{
#   ami = "ami-3573406969"
#   # region = local.region
#   # provider = [local.provider]
#   instance_type = local.instance-type
#   tags = {
#     Name = "test-$(local.region)"
#   }

# }