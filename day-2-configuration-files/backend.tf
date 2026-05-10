terraform {
  backend "s3" {
    bucket = "kavya-unique-bucket"
    key = "day-2/terraform.tfstate"      #day-2 is a folder and terraform.tfstate is a file only created or inserted we need to create a s3 bucket before terraform apply
    region = "us-east-1"
    
  }
}