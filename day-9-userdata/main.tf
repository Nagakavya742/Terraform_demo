resource "aws_instance" "name" {
  instance_type = var.type
  ami= var.ami_id
  user_data = file("test.sh")   #calling test.sh from the current directory
  tags ={
    Name = "test"
  }
}