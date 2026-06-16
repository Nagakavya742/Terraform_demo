provider "aws"{
  
}
terraform {
  required_providers {
    aws = {
      # source = "hashicorp/aws"    #or "openTofu/aws" for OpenTofu-specific registry
      source = "openTofu/aws"
      version = "~> 4.0"
    }
  }
}