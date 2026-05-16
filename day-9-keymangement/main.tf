resource "aws_key_pair" "name" {
  key_name = "dev"
  public_key = file("~/.ssh/id_ed25519.pub")
}


#create instance when u have private key only and then give public key so u can connect to the instance

resource "aws_instance" "name" {
ami = "ami-0a59ec92177ec3fad"   
instance_type = "t2.micro"
key_name = aws_key_pair.name.key_name   #using public key pair
# vpc_security_group_ids = [aws_security_group.name.id]
# associate_public_ip_address = true     #giving public key


}