resource "aws_security_group" "project"{
  name ="devops-project"
  description =  "Allow TLS inbound traffic"
  
  ingress = [   
    for port in [22, 80, 443, 8080, 9000, 3000, 8082, 8081] :  {
      description = "inbound rules"
      from_port = port
      to_port = port
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks= []
      prefix_list_ids = []
      security_groups = []
      self = false

    }
    ]
    egress {
    from_port = 0
    to_port= 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}
    
  

#for each is used for creating multiple resources
#all ports are same with  cidr same 
#just work like for loop