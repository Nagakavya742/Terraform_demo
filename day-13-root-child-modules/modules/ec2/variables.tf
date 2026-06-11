####since we are creating modules so wwe are not supposed to give hardcoded vales

# variable "ami"{
#   default = "ami-0a59ec92177ec3fad"
#   type = string
# }
# variable "instance_type" {
#   default = "t2.micro"
#   type = string

# }
# variable "subnet_id"{
#   default = ""
#   type = string
# }

#####here modules can be used for getting values

variable "ami"{}
variable "instance_type"{}
variable "subnet_1_id"{}
