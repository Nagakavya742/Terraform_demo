provider "aws"{

}

#Key pair

resource "aws_key_pair" "example1"{
  key_name = "dev"
  public_key = file("C:/Users/PAVAN SAI KUMAR/.ssh/id_rsa.pub")
}

#VPC

resource "aws_vpc" "myvpc"{
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "MyVPC"
  }
}

#subnet

resource "aws_subnet" "sub1"{
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet"
  }
}

#internet gateway

resource "aws_internet_gateway" "igw"{
  vpc_id = aws_vpc.myvpc.id
}

#route table

resource "aws_route_table" "RT"{
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

#associate route table

resource "aws_route_table_association" "RTA"{
  subnet_id = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}

#security groups

resource "aws_security_group" "websg"{
  name = "web"
  vpc_id = aws_vpc.myvpc.id
  
  ingress{
    description = "Allow HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    description = "Allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#instance (Ubuntu)

resource "aws_instance" "server"{
  ami = "ami-091138d0f0d41ff90"
  instance_type = "t2.micro"
  key_name = aws_key_pair.example1.key_name
  vpc_security_group_ids = [aws_security_group.websg.id]
  subnet_id = aws_subnet.sub1.id
  associate_public_ip_address = true

  tags = {
    Name = "ubuntu server"
  }

#   connection {
#     type = "ssh"   #correct for ubuntu server
#     user = "ubuntu"             #ubuntu user for ubuntu and ec2 user for linux
#      private_key = file("C:/Users/PAVAN SAI KUMAR/.ssh/id_rsa")
#     host = self.public_ip     #or aws_instance.server.public_ip
#     timeout = "2m"
#   }

  # provisioner "file" {
  #   source = "file10"
  #   destination = "/home/ubuntu/file10"
 
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "touch /home/ubuntu/file200",
  #     "echo 'hello from local side' >> /home/ubuntu/file200"
  #   ]
  }

  # provisioner "local-exec" {
  #   command = "touch file500"
  # }
# }

resource "null_resource" "run_script"{
  provisioner "remote-exec" {
    connection {
      host = aws_instance.server.public_ip
      user = "ubuntu"
       private_key = file("C:/Users/PAVAN SAI KUMAR/.ssh/id_rsa")
    }

    inline =[
      "echo 'hello from remote side provisioner' >> /home/ubuntu/file200.sh"
    ]
       
  }
  # triggers = {
  #     always_run = "${timestamp()}"   #always run the provisioner
  #   }
}


# rerunning null_resource depends on timestamp not on content modification ...because state values is not tracking inside the contnet
#solution-2 to rerun the provisioner
#use terraform taint to manually mark the resource for the recreation
#terraform taint aws_instance.server
#terraform apply


