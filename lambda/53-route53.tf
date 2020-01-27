
resource "aws_api_gateway_domain_name" "default" {
  domain_name     = var.domain_name
  certificate_arn = module.domain.certificate_arn
}

resource "aws_api_gateway_base_path_mapping" "default" {
  api_id      = aws_api_gateway_rest_api.default.id
  stage_name  = aws_api_gateway_deployment.default.stage_name
  domain_name = aws_api_gateway_domain_name.default.domain_name
}

resource "aws_route53_record" "default" {
  zone_id = module.domain.zone_id

  name = var.domain_name
  type = "A"

  alias {
    name                   = aws_api_gateway_domain_name.default.cloudfront_domain_name
    zone_id                = aws_api_gateway_domain_name.default.cloudfront_zone_id
    evaluate_target_health = "false"
  }
}
