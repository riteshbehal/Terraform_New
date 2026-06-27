variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "ap-south-1"
}

variable "Security_Group"{
    type = list(string)
    default = ["sg-0cd2d0237a8aba1b0", "sg-030c4b47d10d7f71c", "sg-0be7cec84a04dd053"]
}

variable "AMIS" {
    type = map(string)
    default = {
        ap-south-1 = "ami-0bc7aabcf58d1e02a"
        us-east-2 = "ami-05692172625678b4e"
        us-west-2 = "ami-0352d5a37fb4f603f"
        us-west-1 = "ami-0f40c8f97004632f9"
    }
}
