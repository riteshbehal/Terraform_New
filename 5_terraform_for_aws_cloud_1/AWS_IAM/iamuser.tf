# Create IAM Users

resource "aws_iam_user" "adminuser1" {
  name = "adminuser1"
}

resource "aws_iam_user" "adminuser2" {
  name = "adminuser2"
}

# Create IAM Group

resource "aws_iam_group" "admingroup" {
  name = "admingroup"
}

# Add Users to Group

resource "aws_iam_group_membership" "admin_users" {
  name = "admin-users"

  users = [
    aws_iam_user.adminuser1.name,
    aws_iam_user.adminuser2.name
  ]

  group = aws_iam_group.admingroup.name
}

# Attach Administrator Access Policy to Group

resource "aws_iam_policy_attachment" "admin_users_attach" {
  name       = "admin-users-attach"
  groups     = [aws_iam_group.admingroup.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}