terraform {
  backend "s3" {
    bucket = "kavya-unique-bucket"     
    key = "day-2/terraform.tfstate"     #automatically create folder and don't override the existing statefile code  
    region = "us-east-1"
    
  }
}