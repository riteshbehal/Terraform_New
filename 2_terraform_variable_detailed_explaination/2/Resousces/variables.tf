variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "us-east-1"
}

variable "Security_Group"{
    type = list
    default = ["sg-02718ca0628b6182e", "sg-0b6ad9e2df22b477d", "sg-08317442a2ad694f5"]
}

variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-0b6d9d3d33ba97d99"
        us-east-2 = "ami-05692172625678b4e"
    }
}
