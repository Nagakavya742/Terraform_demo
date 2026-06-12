provider "aws"{
  region = "us-east-1"
  profile = "default"
}

module "vpc"{
  source = "../../modules/vpc"
  cidr_block = var.cidr_block
  subnet_1_cidr = var.subnet_1_cidr
  subnet_2_cidr = var.subnet_2_cidr
  azs1 = var.azs1
  azs2 = var.azs2
}

module "ec2"{
  source = "../../modules/ec2"
  ami = var.ami
  instance_type = var.instance_type 
  subnet_1_id = module.vpc.subnet_1_id
  subnet_2_id = module.vpc.subnet_2_id
  
  name = var.name
  
}

module "rds"{
  source = "../../modules/rds"
  subnet_1_id = module.vpc.subnet_1_id
  subnet_2_id = module.vpc.subnet_2_id
  instance_class = var.instance_class
  db_name = var.db_name
  user = var.user
  password = var.password
}

module "s3"{
  source = "../../modules/s3"
  bucket_name = var.bucket_name
}