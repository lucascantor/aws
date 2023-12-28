# ------------------------------------------------------------------------------------------
# AWS account alias

resource "aws_iam_account_alias" "alias" {
  account_alias = "cantor"
}

# ------------------------------------------------------------------------------------------
# IAM OIDC identity providers

data "tls_certificate" "tfc_certificate" {
  url = "https://${var.tfc_hostname}"
}

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

resource "aws_iam_group" "admin" {
  name = "admin"
}

resource "aws_iam_group_membership" "admin" {
  name = "tf-admin-group-membership"

  users = [
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
