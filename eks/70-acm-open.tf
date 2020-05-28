# acm open

resource "aws_acm_certificate" "open" {
  count = var.host_root != "" ? var.host_open != "" ? 1 : 0 : 0

  domain_name       = var.host_open
  validation_method = "DNS"
}

resource "aws_route53_record" "open" {
  count = var.host_root != "" ? var.host_open != "" ? 1 : 0 : 0

  zone_id = data.aws_route53_zone.this[0].id
  name    = aws_acm_certificate.open[0].domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.open[0].domain_validation_options[0].resource_record_type
  ttl     = 60

  records = [
    aws_acm_certificate.open[0].domain_validation_options[0].resource_record_value,
  ]
}

resource "aws_acm_certificate_validation" "open" {
  count = var.host_root != "" ? var.host_open != "" ? 1 : 0 : 0

  certificate_arn = aws_acm_certificate.open[0].arn

  validation_record_fqdns = [
    aws_route53_record.open[0].fqdn,
  ]
}

output "acm-open" {
  value = aws_acm_certificate.open.*.arn
}
