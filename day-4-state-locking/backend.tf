terraform {
  backend "s3" {
    bucket = "kavya-unique-bucket"     
    key = "terraform.tfstate"     #statefile is the key to apply in s3 bucket 
    region = "us-east-1"
    
  }
}