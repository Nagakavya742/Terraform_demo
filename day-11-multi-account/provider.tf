provider "aws"{
  region = "us-east-1"
}
provider "aws"{
  region = "us-west-2"
  alias = "Oregon"
  profile = "test"
}

#above providers are duplicate as both are providers
#default account is provided by giving the aws credentials
#we create multi account by giving different aws credentials
#so the requires resource created in required account with same main.tf file 


#aws configure --profile test(profile name can be ur account name or any that you can understand)
  #give access and secret keys
  #we created multi account
