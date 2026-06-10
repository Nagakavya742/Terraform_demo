# resource "aws_instance" "server"{
#  ami = "ami-091138d0f0d41ff90"
#  instance_type = "t2.micro"
#  count = 2
#   tags = {
#    Name = "Server"
#   }
#    tags = {
#      Name = "Server-${count.index}"
#    }
#   }

variable "env"{
  type = list(string)
  default = ["dev", "prod"] 
  #it gives length to count and names for server
}


resource "aws_instance" "server"{
 ami = "ami-091138d0f0d41ff90"
 instance_type = "t2.micro"
 count = length(var.env)
#  tags = {
#   Name = "Server"
#  }
  tags = {
    Name = var.env[count.index]  
    #get the length of count from the variable so it create that many resources with that names
  }
 }

#count is used to create multiple resources with same information
#count.index is used to create multiple resources with different tags of names 
#ex- dev-0 and dev-1