variable "region" {
  default = "us-east-1"
}

variable "public_key_path" {
  default = "/root/.ssh/levelup_key.pub"
}

variable "instance_ami" {
  default = "ami-0b6d9d3d33ba97d99"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "environment_tag" {
  default = "production"
}