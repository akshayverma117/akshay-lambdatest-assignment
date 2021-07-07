variable "ami" {
default = "ami-0ab4d1e9cf9a1215a"
}
variable "instancetype" {
default = "t3a.micro"
}
variable "subnet_id"{
type = string
default = null
}
variable "key_name"{}
