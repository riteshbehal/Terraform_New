resource "aws_s3_bucket" "levelup_s3bucket" {

  bucket = "terraform-lab-project-20260619-001"

  tags = {
    Name        = "terraform-lab-project-20260619-001"
    Environment = "Development"
    Project     = "Terraform-Learning"
  }
}