platform                  = "ENVPOC"
aws_region                = "ap-south-1"
terraform_version         = ">= 0.13.0"
#vpc_id                    = data.terraform_remote_state.vpc.outputs.vpc_id
ec2_jump_pem_path         = "terraform"
#subnet_id                 = data.terraform_remote_state.vpc.outputs.private_subnets[0]
#vpc_cidr                  = data.terraform_remote_state.vpc.outputs.vpc_cidr
