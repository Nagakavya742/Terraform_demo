resource "aws_db_instance" "default" {
  allocated_storage = 10
  db_name = "mydb"
  identifier = "rds-test"
  # availability_zones = ["us-east-1a"]
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t2.micro"   #free tier is t series
  username = "admin"
  password = "pavan@123"    #self credentials
  parameter_group_name = "default.mysql8.0"
  db_subnet_group_name = "aws_db_subnet_group.sub-grp.id"   #here it calls subnets and the subnets call the ids form data {} resource

  #Enable backups and retention
  backup_retention_period = 7  #retain backups for & days
  backup_window = "01:00-02:00"  #daily backup window (UTC)


  #Enable monitoring(Cloudwatch Enhanced Monitoring)
  # monitoring_interval = "30"     #collect metric every 30 seconds
  # monitoring_role_arn = "arn:aws:iam::123456789012:role/monitoring-role"
  # monitoring_role_name = "monitoring-role"

  #Enable performance insights
  # performance_insights_enabled = true           #insights are not eligible for free tier
  # performance_insights_retention_period = 7   #retain insights for 7 days

  #maintenance window
  maintenance_window = "Mon:00:00-Mon:03:00"  #maintain every sunday (UTC)

  #Enable delete protection
  deletion_protection = true

  #skip final snapshot
  skip_final_snapshot = true

}

#IAM role for RDS Enhanced Monitoring
# resource "aws_iam_role" "rds_monitoring" {
#   name = "rds-monitoring"
#   assume_role_policy = jsondecode({
#     version = "2012-10-17"
#     statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "monitoring.rds.amazonaws.com"
#       }
#     }]
#   })
  
# }
#







#############HERE WE OBTAIN EXISTING SUBNETS BY DATA BLOCK #####################
#IAM policy attachment
resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
  role = aws_iam_role.rds_monitoring.name                               #by searching AmazonRDSEnhancedMonitoringRole in IAM policies select it and copy the arn there and paste in below arn so iam role will create
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"

}

resource "aws_db_subnet_group" "sub-grp" {
  name = "mysubnetgrp"
  subnet_ids = [data.aws_subnet.subnet_1.id,data.aws_subnet.subnet_2.id,"subnet-0e9d3d8f8d4d8d8d8"]
  
  tags = {
    Name = "my db subnet group"
  }
}



#Datablock
data "aws_subnet" "subnet_1" {
  filter {
    name   = "subnet-id"
    values = ["subnet-0a5c3407e453502f7"]   #while encoding or reusing the code give existing  subnet ids
  }
}

data "aws_subnet" "subnet_2" {
  filter {
    name   = "subnet-id"
    values = ["subnet-07f123456789abcd"]
  }
}

# resource "aws_db_instance" "default" {
#   allocated_storage = 10
#   db_name           = "mydb"
#   identifier = "rds-test"

#   engine         = "mysql"
#   engine_version = "8.0"
#   instance_class = "db.t3.micro"

#   username = "admin"
#   password = "pavan@123"

#   parameter_group_name = "default.mysql8.0"

#   db_subnet_group_name = aws_db_subnet_group.sub-grp.name

#   backup_retention_period = 7
#   backup_window           = "01:00-02:00"

#   maintenance_window = "Mon:00:00-Mon:03:00"

#   deletion_protection = true

#   skip_final_snapshot = true
# }

# resource "aws_db_subnet_group" "sub-grp" {
#   name = "mysubnetgrp"

#   subnet_ids = [
#     data.aws_subnet.subnet_1.id,
#     data.aws_subnet.subnet_2.id
#   ]

#   tags = {
#     Name = "my db subnet group"
#   }
# }

# data "aws_subnet" "subnet_1" {
#   filter {
#     name   = "subnet-id"
#     values = ["subnet-0a5c3407e453502f7"]
#   }
# }

# data "aws_subnet" "subnet_2" {
#   filter {
#     name   = "subnet-id"
#     values = ["subnet-07f123456789abcd"]
#   }
# }















































