resource "aws_instance" "server"{
  ami = "ami-091138d0f0d41ff90"
  instance_type = "t2.micro"
  tags = {
    Name = "Server"
  }

  #it take default provider as we not provided any region or provider
}

resource "aws_s3_bucket" "name"{
  bucket = "kavya-unique-bucket"
  provider = aws.california  #here we are giving the particular region in which the resource should be created
}