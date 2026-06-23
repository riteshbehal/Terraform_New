variable "AWS_ACCESS_KEY" {
    type = string
    default = "AKIASMSIZOF42P2VUDSZ"
}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "us-east-1"
}

variable "Security_Group"{
    type = list
    default = ["sg-24076", "sg-90890", "sg-456789"]
}

variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-0b6d9d3d33ba97d99"
        us-east-2 = "ami-05692172625678b4e"
    }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "levelup_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "levelup_key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}