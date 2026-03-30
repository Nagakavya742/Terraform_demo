terraform {
  backend "s3" {
    bucket = "kavya-unique-bucket"
    key = "terraform.tfstate"
    region = "us-east-1"
    
  }
}