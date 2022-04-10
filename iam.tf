# ------------------------------------------------------------------------------------------
# AWS account alias

resource "aws_iam_account_alias" "alias" {
  account_alias = "cantor"
}

# ------------------------------------------------------------------------------------------
# IAM users

resource "aws_iam_user" "terraform" {
  name = "terraform"
}

resource "aws_iam_user" "lucas" {
  name = "lucas"
}

# ------------------------------------------------------------------------------------------
# IAM groups

resource "aws_iam_group" "admin" {
  name = "admin"
}

resource "aws_iam_group_membership" "admin" {
  name = "tf-admin-group-membership"

  users = [
    aws_iam_user.terraform.name,
    aws_iam_user.lucas.name,
  ]

  group = aws_iam_group.admin.name
}

data "aws_iam_policy" "admin" {
  name = "AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "admin_group_admin_policy" {
  group      = aws_iam_group.admin.name
  policy_arn = data.aws_iam_policy.admin.arn
}
