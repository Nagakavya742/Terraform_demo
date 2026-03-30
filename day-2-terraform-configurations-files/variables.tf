variable "ami_id" {
  description = "passing the ami vales"
  default = ""
  type = string
  
}
variable "instance_type" {
  description = "passing type to main"
  default = ""
  type = string
  
}
variable "aws_subnet" {
  description = "passing subnet to main"
  default = ""
  type = string
}