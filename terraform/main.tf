#creating_vpc
resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "my_vpc"
    purpose = "assignment"
  }
enable_dns_hostnames = "true"
}

#creating_public_subnet

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
 availability_zone = "us-east-1a"

  tags = {
    Name = "public-subnet"
    purpose = "assignment-subnet1"
  }
}

#creating_private_subnet

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
availability_zone = "us-east-1b"

  tags = {
    Name = "private"
    purpose = "assignment-subnet2"
  }
}

#creating_securitygroup

resource "aws_security_group" "myassignment-sg" {
  name        = "mytask-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id
 
  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  tags = {
    Name = "my-sg"
    purpose = "assignment-sg"
  }
 
}
 
#creating_internet-gateway

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.my_vpc.id
 
  tags = {
    Name = "myigw"
    purpose = "assignment"
  }
}

#creating_route_table_for_public-subnet
 
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my_vpc.id
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = "public-rt"
    purpose = "assignment"
  }
}

#associating_route_table_with_public-subnet

resource "aws_route_table_association" "publicassociation" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}



#creating eip for nat


resource "aws_eip" "nat_eip" {
  
  vpc      = true
}






#creating nat



resource "aws_nat_gateway" "my_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "NAT"
  }


}



#creating_route_table_private

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my_nat.id
  }
  tags = {
    Name = "private-rt"
    purpose = "assignment"
  }
}

#associating_route_table-private

resource "aws_route_table_association" "privateassociation" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-rt.id
}


#creating_keypair

resource "aws_key_pair" "my-ssh-key" {
  key_name   = "my-ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCk7jF0EHKxd/pmwJF4mYWQoiJKj9MNM8VhQloCyBiuJAZ1iWgnoFcNMiBsiWXZlrFzc3AbR1j/FlMsns2ci6ue2z2dWrlfepocCKWFuQzLUHGnUB0BYwgyZQVNEV+JyToftP2d4ESzyk3ix+LWGPbWg+t5wJDFZIQixb7lxfU7IYeo9Bppl3YIUxMX7JPKobsNNB+HpU4P11tKWZGFuxkwVFGYbvA16gAigV1cBYqnoM2elHqlXorI40+4kjb1QRA8hhuJlyab6S7ehNXFteYhv/EHSUKhgoFWkM9bGfnh+TZbulaYcQ717k8XBb+0JUAAVNar0icfBCUo/gmoa3UoHPRm0YQujLwiw2dSkxuEj2htnC7esV3tvaIybT57tcqNzpUoBHhBd4bmsP2JZmwjwIPO5XVRhC+y/tlTSTymuDD+XTe0a7ti+yi8yfbM3l7ojqW1+n8Mm3ZG7qliJm0YkZDTqHF9+gXhjs9KY+WsleWZo+YUdwRuPEJAs5yeCas= ubuntu@ip-172-31-21-129"
}



module "my-module" {
source = "./module"
subnet_id = aws_subnet.private-subnet.id 
key_name = aws_key_pair.my-ssh-key.id

}

