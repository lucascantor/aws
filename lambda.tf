# ------------------------------------------------------------------------------------------
# Lambda function to invalidate CloudFront distributions

data "aws_iam_policy_document" "policy_for_cloudfront_invalidation_lambda" {
  policy_id = "policy_for_cloudfront_invalidation_lambda"
  statement {
    actions = [
      "cloudfront:CreateInvalidation",
    ]
    resources = [
      "arn:aws:cloudfront::${var.aws_account_id}:distribution/*",
    ]
    sid = "1"
  }
}

resource "aws_iam_policy" "policy_for_cloudfront_invalidation_lambda" {
  name = "policy_for_cloudfront_invalidation_lambda"

  policy = data.aws_iam_policy_document.policy_for_cloudfront_invalidation_lambda.json
}

data "aws_iam_policy_document" "policy_for_cloudfront_invalidation_lambda_assume_role_policy" {
  policy_id = "policy_for_cloudfront_invalidation_lambda_assume_role_policy"
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
    sid = "1"
  }
}

resource "aws_iam_role" "policy_for_cloudfront_invalidation_lambda" {
  name = "policy_for_cloudfront_invalidation_lambd"

  assume_role_policy = data.aws_iam_policy_document.policy_for_cloudfront_invalidation_lambda_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "policy_for_cloudfront_invalidation_lambda" {
  role       = aws_iam_role.policy_for_cloudfront_invalidation_lambda.name
  policy_arn = aws_iam_policy.policy_for_cloudfront_invalidation_lambda.arn
}

resource "aws_lambda_function" "cloudfront_invalidation_lambda" {
  filename         = "lambda_functions/lambda_invalidate_cloudfront.zip"
  function_name    = "cloudfront_invalidation_lambda"
  handler          = "lambda_invalidate_cloudfront.lambda_handler"
  publish          = true
  runtime          = "python3.9"
  role             = aws_iam_role.policy_for_cloudfront_invalidation_lambda.arn
  source_code_hash = filebase64sha256("lambda_functions/lambda_invalidate_cloudfront.zip")
}

resource "aws_lambda_alias" "cloudfront_invalidation_lambda_latest_alias" {
  name             = "cloudfront_invalidation_lambda_latest_alias"
  function_name    = aws_lambda_function.cloudfront_invalidation_lambda.function_name
  function_version = "$LATEST"
}
