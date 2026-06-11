resource "aws_instance" "ec2" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_1_id

  tags = {
    Name = "WebServer"
  }
}