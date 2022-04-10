# ------------------------------------------------------------------------------------------
# AWS account alias

resource "aws_iam_account_alias" "alias" {
  account_alias = "cantor"
}
