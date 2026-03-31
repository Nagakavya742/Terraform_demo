terraform {
  backend "s3" {
    bucket = "kavya-unique-bucket"     
    key = "terraform.tfstate"     #statefile is the key to apply in s3 bucket 
    use_lockfile = true         #use s3 native locking  locking and useful for above 1.19 version only
    region = "us-east-1"
    dynamodb_table = "kavya"    #any version we can use dynamodb   dynamodb name should be statefile name only
    encrypt = true    #both can't be used ate same time either state lock or dynamodb
            
  }
}