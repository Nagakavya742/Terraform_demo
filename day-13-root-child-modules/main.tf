module "vpc"{
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  subnet_1_cidr = "10.0.1.0/24"
  subnet_2_cidr = "10.0.2.0/24"
  azs1 = "us-east-1a"
  azs2 = "us-east-1b"

}

module "ec2"{
  source = "./modules/ec2"
  ami = "ami-0a59ec92177ec3fad"
  instance_type = "t2.micro"
  subnet_1_id = module.vpc.subnet_1_id
}

module "rds"{
  source = "./modules/rds"
  subnet_1_id = module.vpc.subnet_1_id
  subnet_2_ids = module.vpc.subnet_2_ids
  instance_class = "db.t2.micro"
  db_name = "mydb"
  user = "admin"
  password = "password"
}

module "s3"{
  source = "./modules/s3"
  bucket_name = "MyBucket"
}