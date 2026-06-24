module "ec2_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name          = "my-cluster"
  ami           = "ami-0f40c8f97004632f9"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0b5783ef03796c671"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}