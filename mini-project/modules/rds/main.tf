resource "aws_db_subnet_group" "db_subnet_group"{
  name = "db_subnet_group"
  subnet_ids = [var.subnet_1_id,var.subnet_2_id] #subnet_ids
  tags = {
    Name = "My DB subnet group"
  }
}



####rds require minimum 2 subnets to create
resource "aws_db_instance" "mysql"{
  allocated_storage = 10
  engine = "mysql"
  engine_version = "8.0"
  instance_class = var.instance_class
  db_name = var.db_name
  username = var.user
  password = var.password
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  skip_final_snapshot = true
}