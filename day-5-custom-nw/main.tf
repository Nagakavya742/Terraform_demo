#create vpc

resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags={
    Name = "cust_vpc"
  } 
}

#create subnet

resource "aws_subnet" "name-1" {
  vpc_id = aws_vpc.name.id    #above resource consist of aws_vpc so we given aws_vpc not aws.vpc
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "cust-subnet-1-public"
  } 
}

resource "aws_subnet" "name-2"{     #above resource consist of aws_vpc so we given aws_vpc not aws.vpc
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "cust-subnet-2-private"
  } 
}

#create internet gateway and attach to vpc

resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.name.id
  tags={
    Name = "cust-ig"
  }
  
}
#create route table and edit routes
resource "aws_route_table" "name" {
  vpc_id = aws_vpc.name.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }
  
}
#create subnet association

resource "aws_route_table_association" "name" {
  subnet_id = aws_subnet.name-1.id
  route_table_id = aws_route_table.name.id
  
}
#create sg

resource "aws_security_group" "name" {
  name = "allow_tls"
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "cust-sg"
  }  
  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS"
    from_port = 443
    to_port = 443
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "outbound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

#create servers

resource "aws_instance" "pub" {
  ami = "ami-0a59ec92177ec3fad"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.name-1.id
  vpc_security_group_ids = [aws_security_group.name.id]   #sg is under the list because we have many sg rules
  associate_public_ip_address = true
  tags = {
    Name = "public-ec2"
  }
}
resource "aws_instance" "pvt" {
  ami = "ami-0a59ec92177ec3fad"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.name-2.id
  vpc_security_group_ids = [aws_security_group.name.id]   #sg is under the list because we have many sg rules
  associate_public_ip_address = true
  tags = {
    Name = "private-ec2"
  }
}

#create EIP

# resource "aws_elastic" "name" {
  
# }
#create nat
#create RT and edit routes
#route table association