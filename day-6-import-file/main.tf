resource "aws_instance" "name" {
  ami = "ami-0a59ec92177ec3fad"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  tags = {
    Name = "test"
  }
  
}


#main.tf we manually created  and should handle
#terraform.tf we created automatically

#from the import command state file is created and form that state file
#we extract the detail of manually created resource and update the main file according to the state file
#main.tf should match with existing manually created resource so that we can import the resource
#and if both are not matched it deletes the manually created resource and create another resource regarding the details of state file
#we need to take care of the designing the local blocks or else the existing will be deleted

#1)created server manually
#2)create main.tf and don't give nay information just resource{}
#3)next give import command and state file will be created
     #terraform import aws_instance.name i-0a59ec92177ec3fad
#4)now we can update the main.tf according to the state file
#desired state to current state

#if terraform plan give no changes then only proceed terraform apply
#if terraform plan give changes then change the current state configurations according to the state file (desired state)




