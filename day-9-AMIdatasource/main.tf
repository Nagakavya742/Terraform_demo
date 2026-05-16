data "aws_subnet" "name" {
  filter {
    name = "tag:Name"
    values = ["test"]   #insert the value here  it will call test subnet
  }
}
data "aws_ami" "amzlinux" {
  owners = ["amazon"]
  most_recent = true   #from the most recent ami called that satisfy the below filters
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp3"]
  }
  filter{
    name = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter{
    name = "architecture"
    values = [ "x86_64" ]
  }
  
}
# data "aws_ami" "linuxamz" {
#   most_recent = true
#   owners = ["self"]
#   filter {
#     name = "name"
#     values = ["development-ami"]   it is created before and we are using it
#   }
#   filter{
#     name = "root-device-type"
#     values = ["ebs"]
#   }
#   filter {
#     name = "virtualization-type"
#     values = ["hvm"]
#   }
#   filter{
#     name = "architecture"
#     values = [ "x86_64" ]
#   }
  
# }

resource "aws_instance" "name" {
  ami = data.aws_ami.amzlinux.id
  instance_type = "t2.micro"
  subnet_id = data.aws_subnet.name.id
}