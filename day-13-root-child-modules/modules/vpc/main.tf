resource "aws_vpc" "main"{
  cidr_block = var.cidr_block
}

resource "aws_subnet" "main"{
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_1_cidr
  availability_zone = var.azs1
}


resource "aws_subnet" "name"{
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_2_cidr
  availability_zone = var.azs2
}


# resource "availability_zone" "azs"{
#   name = var.az
# }


  # output "vpc_id"{
  #   value = aws_vpc.main.id
  # }
  # output "subnet_id"{
  #   value = aws_subnet.main.id
  # }
