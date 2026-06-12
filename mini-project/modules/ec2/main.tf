resource "aws_instance" "project"{
  ami = var.ami
  instance_type = var.instance_type

  subnet_id = var.subnet_1_id

  tags = {
    Name = var.name
  }

}