provider "aws"{

}

#Example EC2 instance (replace with yours if already existing)

resource "aw_instance" "sql_runner"{
  ami = "ami-0a59ec92177ec3fad"
  instance_type = "t2.micro"
  key_name = "keypairdev"
  associate_public_ip_address = true
  availability_zone = "us-east-1a"
  tags = {
    Name = "SQL Runner"
  }
}

#deploy SQl remotely using null resource+remote-exec

resource "null_resource" "remote_sql_exec"{
  depends_on = [aws_db_instance.name , aws_db_instance.sql_runner]
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("~/ssh/keypairdev.pem")
    host = aws_instance.sql_runner.public_ip
  }
  provisioner "file" {
    source = "init.sql"
    destination = "/tmp/init.sql"
    
  }
  provisioner "remote-exec" {
    inline = [ "mysql -h $(aws_db_instance.mysql_rds.address) -u $(jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)[])" ]
    
  }
  triggers = {
    always_run = timestamp() 
  }
}