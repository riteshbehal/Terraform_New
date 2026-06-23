resource "aws_key_pair" "levelup_key" {
  key_name   = "levelup_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "MyFirstInstance" {

  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name = aws_key_pair.levelup_key.key_name

  iam_instance_profile = aws_iam_instance_profile.s3_levelupbucket_role_instanceprofile.name

  tags = {
    Name = "custom_instance"
  }
}

output "public_ip" {
  value = aws_instance.MyFirstInstance.public_ip
}