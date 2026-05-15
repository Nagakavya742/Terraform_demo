#import means if teh resources are created manually before and we need to take terraform control then we use import
#data source  calling the data that exists already creating of the resources does'nt require terraform control
#source means we can use any resource that created in any repo
data "aws_subnet" "subnet-1" {
  filter{
    name = "tag:Name"
    values = ["subnet-1"]
  }
}
data "aws_subnet" "subnet-2" {
  filter{
    name = "tag:Name"
    values = ["subnet-2"]
  }
}
resource "aws_db_subnet_group" "name" {
  name = "mysubnetgrp"
  subnet_ids = [data.aws_subnet.subnet-1.id,data.aws_subnet.subnet-2.id]

  tags = {
    Name = "My DB subnet group"
  }
}



#we can get the existing ami by data source
# data "aws_ami" "latest_ami" {
#   owners = ["self"]    #here it filters according to te requirements
#   most_recent = true    #we acn use most recent ami
# }
