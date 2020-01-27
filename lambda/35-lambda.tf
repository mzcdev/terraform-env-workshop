# Lambda Function

resource "aws_s3_bucket_object" "default" {
  bucket = var.s3_bucket
  source = var.s3_source
  key    = var.s3_key
}

resource "aws_lambda_function" "default" {
  function_name = "${var.stage}-${var.name}"

  s3_bucket = var.s3_bucket
  s3_key    = var.s3_key

  runtime = var.runtime
  handler = var.handler

  memory_size = var.memory_size
  timeout     = var.timeout

  role = aws_iam_role.default.arn

  depends_on = [
    aws_iam_role.default,
    aws_iam_role_policy.default,
    aws_s3_bucket_object.default,
  ]

  environment {
    variables = var.env_vars
  }
}
