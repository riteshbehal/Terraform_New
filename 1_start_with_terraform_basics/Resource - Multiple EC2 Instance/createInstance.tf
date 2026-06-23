provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "MyFirstInstnace" {
  count         = 3
  ami           = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro"

  tags = {
    Name = "demoinstnce-${count.index}"
  }
}
