locals {
  variables ={
    default = {
      ec2 = {
        webserver = {
          name = "webserver"
          count = 1
          type = "t3a.micro"
        }
      }
      s3 = {
        
      }
    }
  }
}

locals {
  environment = "${terraform.workspace}"
}

