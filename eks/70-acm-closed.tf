# acm closed

resource "aws_acm_certificate" "closed" {
  count = var.host_root != "" ? var.host_closed != "" ? 1 : 0 : 0

  domain_name       = var.host_closed
  validation_method = "DNS"
}

resource "aws_route53_record" "closed" {
  count = var.host_root != "" ? var.host_closed != "" ? 1 : 0 : 0

  zone_id = data.aws_route53_zone.this[0].id
  name    = aws_acm_certificate.closed[0].domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.closed[0].domain_validation_options[0].resource_record_type
  ttl     = 60

  records = [
    aws_acm_certificate.closed[0].domain_validation_options[0].resource_record_value,
  ]
}

resource "aws_acm_certificate_validation" "closed" {
  count = var.host_root != "" ? var.host_closed != "" ? 1 : 0 : 0

  certificate_arn = aws_acm_certificate.closed[0].arn

  validation_record_fqdns = [
    aws_route53_record.closed[0].fqdn,
  ]
}

output "acm-closed" {
  value = aws_acm_certificate.closed.*.arn
}
