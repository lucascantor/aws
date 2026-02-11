# ------------------------------------------------------------------------------------------
# AWS account alias

resource "aws_iam_account_alias" "alias" {
  account_alias = "cantor"
}

# ------------------------------------------------------------------------------------------
# IAM OIDC identity providers

# GitHub Actions OIDC identity provider TLS certificate
data "tls_certificate" "github_actions_certificate" {
  url = "https://${var.github_actions_hostname}"
}

# GitHub Actions OIDC identity provider
resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = data.tls_certificate.github_actions_certificate.url
  client_id_list  = [var.github_actions_aws_audience]
  thumbprint_list = [data.tls_certificate.github_actions_certificate.certificates[0].sha1_fingerprint]
}

# ------------------------------------------------------------------------------------------
# IAM users

resource "aws_iam_user" "lucas" {
  name = "lucas"
}

# ------------------------------------------------------------------------------------------
# IAM groups

# Admin group
resource "aws_iam_group" "admin" {
  name = "admin"
}

# Admin group membership
resource "aws_iam_group_membership" "admin" {
  name = "tf-admin-group-membership"

  users = [
    aws_iam_user.lucas.name,
  ]

  group = aws_iam_group.admin.name
}

# ------------------------------------------------------------------------------------------
# IAM roles

# Role for GitHub Actions to assume for the aws repo
resource "aws_iam_role" "github_actions_sts_assumption_role_aws" {
  name = "github-actions-sts-assumption-role-aws"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Effect": "Allow",
     "Principal": {
       "Federated": "${aws_iam_openid_connect_provider.github_actions.arn}"
     },
     "Action": "sts:AssumeRoleWithWebIdentity",
     "Condition": {
       "StringEquals": {
         "token.actions.githubusercontent.com:aud": "${var.github_actions_aws_audience}"
       },
       "StringLike": {
         "token.actions.githubusercontent.com:sub": "repo:${var.github_actions_organization_name}/${var.github_actions_repo_name_aws}:*"
       }
     }
   }
 ]
}
EOF
}

# ------------------------------------------------------------------------------------------
# IAM policies

# AWS-managed admin policy
data "aws_iam_policy" "admin" {
  name = "AdministratorAccess"
}

# Attachment of AWS-managed admin policy to admin group
resource "aws_iam_group_policy_attachment" "admin_group_admin_policy" {
  group      = aws_iam_group.admin.name
  policy_arn = data.aws_iam_policy.admin.arn
}

# Attachment of AWS-managed admin policy to GitHub Actions STS assumption role for the aws repo
resource "aws_iam_role_policy_attachment" "github_actions_sts_assumption_role_aws_admin_policy" {
  role       = aws_iam_role.github_actions_sts_assumption_role_aws.name
  policy_arn = data.aws_iam_policy.admin.arn
}
