# ------------------------------------------------------------------------------------------
# AWS account alias

resource "aws_iam_account_alias" "alias" {
  account_alias = "cantor"
}

# ------------------------------------------------------------------------------------------
# IAM OIDC identity providers

resource "aws_iam_openid_connect_provider" "terraform_cloud" {
  url = "https://app.terraform.io"

  client_id_list = [
    "aws.workload.identity",
  ]

  thumbprint_list = [
    "9E99A48A9960B14926BB7F3B02E22DA2B0AB7280",
  ]
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

# ------------------------------------------------------------------------------------------
# IAM roles

resource "aws_iam_role" "terraform_cloud_sts_assumption_role" {
  name = "terraform-cloud-sts-assumption-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "${aws_iam_openid_connect_provider.terraform_cloud.arn}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "app.terraform.io:aud": "aws.workload.identity",
                    "app.terraform.io:sub": "organization:unitizer:project:*:workspace:aws:run_phase:*"
                }
            }
        }
    ]
}
EOF
}

# ------------------------------------------------------------------------------------------
# IAM policies

data "aws_iam_policy" "admin" {
  name = "AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "admin_group_admin_policy" {
  group      = aws_iam_group.admin.name
  policy_arn = data.aws_iam_policy.admin.arn
}

resource "aws_iam_role_policy_attachment" "terraform_cloud_sts_assumption_role_admin_policy" {
  role       = aws_iam_role.terraform_cloud_sts_assumption_role.name
  policy_arn = data.aws_iam_policy.admin.arn
}
