
variable "env"{
  type = list(string)
  default = ["dev", "prod"] 
  #it gives length to count and names for server
}


resource "aws_instance" "server"{
 ami = "ami-091138d0f0d41ff90"
 instance_type = "t2.micro"
 for_each = toset(var.env)   #works based on index
#  tags = {
#   Name = "Server"
#  }
  tags = {
    Name = each.value 
    #get the length of count from the variable so it create that many resources with that names
  }
 }
 #as like count it does'nt destroy as per the index
 #but destroy as per the instruction 
 #here iterations are performed based on the length