create_vpc       = true
project_name     = "akshay-poc"
env_name         = "default"
vpc_cidr         = "10.1.0.0/16"
azs              = ["ap-south-1a", "ap-south-1b"]
private_subnets  = ["10.1.1.0/24", "10.1.2.0/24"]
public_subnets   = ["10.1.3.0/24", "10.1.4.0/24"]
aws_region="ap-south-1"


