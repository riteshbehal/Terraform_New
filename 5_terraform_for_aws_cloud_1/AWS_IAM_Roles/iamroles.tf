# IAM Role for EC2 to Access S3

resource "aws_iam_role" "s3_levelupbucket_role" {

  name = "s3-levelupbucket-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Action = "sts:AssumeRole"

        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Policy Attached to Role

resource "aws_iam_role_policy" "s3_levelupbucket_role_policy" {

  name = "s3-levelupmybucket-role-policy"

  role = aws_iam_role.s3_levelupbucket_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:*"
        ]

        Resource = [
          aws_s3_bucket.levelup_s3bucket.arn,
          "${aws_s3_bucket.levelup_s3bucket.arn}/*"
        ]
      }
    ]
  })
}

# Instance Profile

resource "aws_iam_instance_profile" "s3_levelupbucket_role_instanceprofile" {

  name = "s3-levelupbucket-role"

  role = aws_iam_role.s3_levelupbucket_role.name
}