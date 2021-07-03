data "aws_ami" "ubuntu_bionic" {
  owners = ["amazon"]

  filter {
    name = "name"

    values = ["Ubuntu_18.04-x86_64*"]
  }
  most_recent = true
}

data "aws_ami" "ubuntu_xenial" {
  owners = ["amazon"]

  filter {
    name = "name"

    values = ["ubuntu-xenial-16.04-amd64-server-*"]
  }
  most_recent = true
}


