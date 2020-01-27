
resource "aws_api_gateway_rest_api" "default" {
  name = "${var.stage}-${var.name}"
}

resource "aws_api_gateway_resource" "default" {
  rest_api_id = aws_api_gateway_rest_api.default.id
  parent_id   = aws_api_gateway_rest_api.default.root_resource_id
  path_part   = var.path_part // {proxy+}
}

resource "aws_api_gateway_method" "default" {
  count = length(var.http_methods)

  rest_api_id   = aws_api_gateway_rest_api.default.id
  resource_id   = aws_api_gateway_resource.default.id
  http_method   = element(var.http_methods, count.index)
  authorization = "NONE"

  depends_on = [aws_api_gateway_resource.default]
}

resource "aws_api_gateway_integration" "default" {
  count = length(var.http_methods)

  type        = "AWS_PROXY"
  rest_api_id = aws_api_gateway_rest_api.default.id
  resource_id = aws_api_gateway_resource.default.id
  http_method = element(var.http_methods, count.index)
  uri         = aws_lambda_function.default.invoke_arn

  # AWS lambdas can only be invoked with the POST method
  integration_http_method = "POST"

  depends_on = [aws_api_gateway_method.default]
}

resource "aws_api_gateway_deployment" "default" {
  rest_api_id = aws_api_gateway_rest_api.default.id
  stage_name  = var.stage

  depends_on = [aws_api_gateway_integration.default]
}
