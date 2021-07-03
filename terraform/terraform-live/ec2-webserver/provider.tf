terraform {
  backend "s3" {
    bucket               = "akshay-lambdatest"
    key                  = "terraform/webserver/terraform.tfstate"
    region               = "ap-south-1"
    encrypt              = true
  }
}

provider "aws" {
  region                 = var.aws_region
  profile                = "aws-infra"
}
  
