resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instancetype
  subnet_id = var.subnet_id
  key_name = var.key_name
  tags = {
    Name = "My-instance"
  }
}

