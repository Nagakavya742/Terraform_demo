variable "ami" {     #here variable name and name inn main.tf should be same or else it destroy and create another
  type = string
  default = ""
}
variable "instance_type" {
  type = string
  default = ""
  
}