
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

resource "aws_lambda_permission" "default" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.default.arn
  principal     = "apigateway.amazonaws.com"
  statement_id  = "AllowExecutionFromAPIGateway"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  //source_arn = "${aws_api_gateway_deployment.default.execution_arn}/${aws_api_gateway_method.default_get_req.http_method}${aws_api_gateway_resource.default.path}"
  //source_arn = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.default.id}/*/${aws_api_gateway_method.default.http_method}${aws_api_gateway_resource.default.path}"
  source_arn = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.default.id}/*/*"
}
