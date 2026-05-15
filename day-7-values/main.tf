module "name" {
  source = "../day-7-modules"
  ami = var.ami
  instance_type = var.instance_type
  
}