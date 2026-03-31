terraform {
  backend "s3" {
    bucket = "kavya-unique-bucket"     
    key = "terraform.tfstate"     #statefile is the key to apply in s3 bucket 
    use_lockfile = true         #use s3 native locking
    region = "us-east-1"
    
  }
}