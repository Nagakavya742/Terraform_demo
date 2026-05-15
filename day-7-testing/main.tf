module "name" {
  source = "../day-7-modules"
  ami = "ami-0a59ec92177ec3fad"
  instance_type = "t3.micro"
}


#here also we just given direct values by calling the module
#but we can also pass the values from variables
#and we can also create terraform.tfvars for the values assigning
