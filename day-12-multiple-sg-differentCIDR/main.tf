variable "allowed_ports"{
  type = map(string)
  default = {
    22 = "203.0.101.76/32"  #SSH(restrict to office ip)
    80 = "0.0.0.0/0"  #HTTP(Public)
    443 = "0.0.0.0/0"  #HTTPS(Public)
    8080 = "10.0.0.0/16"  #Internal apps(restrict to VPC)
    9000 = "102.161.11.0/24"  #Restricted to internal team
    3309  = "10.0.1.0/24"  #Restricted to internal team
  }
}

resource "aws_security_group" "project"{
  name = "project related to devops"
  description = "allow restricted inbound traffic"

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      description = "inbound rules"
      from_port = ingress.key
      to_port = ingress.key    #here we get key from the map
      protocol = "TCP"
      cidr_blocks = [ingress.value]   #here we get the value from the map
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = false
    }

  }
  egress  {
    from_port = 0
    to_port= 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}