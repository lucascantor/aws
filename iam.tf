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

# Terraform Cloud OIDC identity provider TLS certificate
data "tls_certificate" "tfc_certificate" {
  url = "https://${var.tfc_hostname}"
}

# Terraform Cloud OIDC identity provider
resource "aws_iam_openid_connect_provider" "terraform_cloud" {
  url             = data.tls_certificate.tfc_certificate.url
  client_id_list  = [var.tfc_aws_audience]
  thumbprint_list = [data.tls_certificate.tfc_certificate.certificates[0].sha1_fingerprint]
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

# Role for GitHub Actions to assume for the blog.lucascantor.com repo
resource "aws_iam_role" "github_actions_sts_assumption_role_blog_lucascantor_com" {
  name = "github-actions-sts-assumption-role-blog-lucascantor-com"

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
         "token.actions.githubusercontent.com:sub": "repo:${var.github_actions_organization_name}/${var.github_actions_repo_name_blog_lucascantor_com}:ref:refs/heads/${var.github_actions_branch_name_blog_lucascantor_com}",
         "token.actions.githubusercontent.com:aud": "${var.github_actions_aws_audience}"
       }
     }
   }
 ]
}
EOF
}

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
       "StringLike": {
         "token.actions.githubusercontent.com:aud": "${var.github_actions_aws_audience}",
         "token.actions.githubusercontent.com:sub": "repo:${var.github_actions_organization_name}/${var.github_actions_repo_name_aws}:ref:refs/heads/*"
       }
     }
   }
 ]
}
EOF
}

# Role for Terraform Cloud to assume
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
         "${var.tfc_hostname}:aud": "${one(aws_iam_openid_connect_provider.terraform_cloud.client_id_list)}"
       },
       "StringLike": {
         "${var.tfc_hostname}:sub": "organization:${var.tfc_organization_name}:project:${var.tfc_project_name}:workspace:${var.tfc_workspace_name}:run_phase:*"
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

# Policy to grant read-write access to blog.lucascantor.com S3 bucket
resource "aws_iam_policy" "blog_lucascantor_com_s3" {
  name   = "blog_lucascantor_com_s3"
  policy = data.aws_iam_policy_document.blog_lucascantor_com_s3.json
}

data "aws_iam_policy_document" "blog_lucascantor_com_s3" {
  statement {
    effect = "Allow"

    actions = [
      "s3:List*",
      "s3:Describe*",
      "s3:Get*",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "arn:aws:s3:::blog.lucascantor.com",
      "arn:aws:s3:::blog.lucascantor.com/*",
    ]
  }
}

# Attachment of AWS-managed admin policy to admin group
resource "aws_iam_group_policy_attachment" "admin_group_admin_policy" {
  group      = aws_iam_group.admin.name
  policy_arn = data.aws_iam_policy.admin.arn
}

# Attachment of AWS-managed admin policy to Terraform Cloud STS assumption role
resource "aws_iam_role_policy_attachment" "terraform_cloud_sts_assumption_role_admin_policy" {
  role       = aws_iam_role.terraform_cloud_sts_assumption_role.name
  policy_arn = data.aws_iam_policy.admin.arn
}

# Attachment of AWS-managed admin policy to GitHub Actions STS assumption role for the aws repo
resource "aws_iam_role_policy_attachment" "github_actions_sts_assumption_role_aws_admin_policy" {
  role       = aws_iam_role.github_actions_sts_assumption_role_aws.name
  policy_arn = data.aws_iam_policy.admin.arn
}

# Attachment of policy granting read-write access to blog.lucascantor.com S3 bucket to GitHub Actions STS assumption role for the blog.lucascantor.com repo
resource "aws_iam_role_policy_attachment" "github_actions_sts_assumption_role_blog_lucascantor_com_s3_policy" {
  role       = aws_iam_role.github_actions_sts_assumption_role_blog_lucascantor_com.name
  policy_arn = resource.aws_iam_policy.blog_lucascantor_com_s3.arn
}
