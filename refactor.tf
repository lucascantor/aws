moved {
  from = aws_iam_role.github_actions_sts_assumption_role
  to   = aws_iam_role.github_actions_sts_assumption_role_blog_lucascantor_com
}

moved {
  from = aws_iam_role_policy_attachment.github_actions_sts_assumption_role_admin_policy
  to   = aws_iam_role_policy_attachment.github_actions_sts_assumption_role_blog_lucascantor_com_s3_policy
}
