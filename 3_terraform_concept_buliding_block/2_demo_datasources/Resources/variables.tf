variable "AWS_ACCESS_KEY" {
    type = string
}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "ap-south-1"
}

variable "Security_Group"{
    type = list(string)
    default = ["sg-03480845964d1ed46", "sg-092cd5a7a3aa7d3e8", "sg-0aab1919622996c1c"]
}
