resource "aws_instance" "name" {
  ami = var.ami_id   
  instance_type = var.instance_type    #instance type="t2.medium"    hardcoded type so it is only prioritized because variable calling is not there
  subnet_id = aws_subnet.name
  tags = {
    Name = "dev"
  } 
}
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name ="dev_vpc"
  }
}

resource "aws_subnet" "name" {
  vpc_id = aws_vpc.name.id
  # subnet_id = var.aws_subnet
  cidr_block = "10.0.0.0/24"
}

#if subnet is private and to make it public create -> IG ->route to subnet ->associate to subnet