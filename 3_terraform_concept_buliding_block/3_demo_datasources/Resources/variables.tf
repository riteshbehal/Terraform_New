variable "AWS_ACCESS_KEY" {
    type = string
    default = "AKIASMSIZOF42P2VUDSZ"
}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "us-east-1"
}

variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-0b6d9d3d33ba97d99"
        us-east-2 = "ami-05692172625678b4e"
    }
}

