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

resource "aws_iam_role" "policy_for_cloudfront_invalidation_lambda" {
  name = "policy_for_cloudfront_invalidation_lambda"

  assume_role_policy = data.aws_iam_policy_document.policy_for_cloudfront_invalidation_lambda.json
}

resource "aws_lambda_function" "cloudfront_invalidation_lambda" {
  filename         = "lambda_functions/lambda_invalidate_cloudfront.zip"
  function_name    = "lambda_function_name"
  handler          = "lambda_invalidate_cloudfront.lambda_handler"
  runtime          = "python3.9"
  role             = aws_iam_role.policy_for_cloudfront_invalidation_lambda.arn
  source_code_hash = filebase64sha256("lambda_functions/lambda_invalidate_cloudfront.zip")
}
