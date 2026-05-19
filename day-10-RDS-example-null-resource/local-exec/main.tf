provider "aws"{
  region = "us-east-1"
}

#create the RDS instance
resource "aws_db_instance" "name"{
  identifier = "my-mysql-db"
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t2.micro"
  allocated_storage = 10
  username = "admin"
  password = "pavan@123"
  publicly_accessible = true
  skip_final_snapshot = true

}

#use null resource to execute the SQL script from your local machine
resource "null_resource" "local_sql_exce"{
  depends_on = [ aws_db_instance.name ]
  provisioner "local-exec" {
    command = "mysql -h ${aws_db_insatnce.my-mysql-db.endpoint} -u admin -ppavan@123 < script.sql"
  }
  triggers = {
    always_run = timestamp()
  }
}