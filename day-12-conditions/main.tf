variable "aws_region"{
  description = "The region in which to create the infrastructure"
  type = string
  nullable = false
  default = "us-east-1"  #here we need to define either us-west-1 or eu-west-2 if i give us-west-1 it will give error
  validation {
    condition = var.aws_region == "us-west-1" || var.aws_region == "eu-west-2"
    error_message = "The region must be us-east-1 or eu-west-2."
  }

}

provider "aws"{
  region = "us-west-1"
}

resource "aws_s3_bucket" dev{
  bucket = "statefile-configs"
}

# # #after run this will get error like the variable 'aws_region' must be one of teh following regions

# ####Example-2

variable "create_bucket"{
  type = bool
  default = false 
}
# true means count will update to 1 and false mean count updated to 0 since we given   ? 1 : 0

resource "aws_s3_bucket" "test"{
  count = var.create_bucket ? 1 : 0
  bucket = "Statefile-configs"
}

# ####Example-3
variable "environment"{
  type = bool
  default = true

}

resource "aws_instance" "example"{
  count = var.environment == "prod" ? 3 :1
  ami = "ami-091138d0f0d41ff90"
  instance_type = "t2.micro"

  tags = {
    Name = "example-${count.index}"
  }
}


# #In this case:
# if var.environment == "prod" -> count = 3
# else (like dev,qa, etc) -> count = 1
# terraform apply - var = "environment"