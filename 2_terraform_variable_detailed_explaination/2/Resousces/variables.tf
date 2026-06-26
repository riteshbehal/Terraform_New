variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "us-east-1"
}

variable "Security_Group"{
    type = list(string)
    default = ["sg-03480845964d1ed46", "sg-092cd5a7a3aa7d3e8", "sg-0aab1919622996c1c"]
}

variable "AMIS" {
    type = map(string)
    default = {
        us-east-1 = "ami-0f40c8f97004632f9"
        us-east-2 = "ami-05692172625678b4e"
        us-west-2 = "ami-0352d5a37fb4f603f"
        us-west-1 = "ami-0f40c8f97004632f9"
    }
}
