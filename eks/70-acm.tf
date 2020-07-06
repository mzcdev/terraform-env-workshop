# acm

data "aws_route53_zone" "this" {
  count = var.root_domain != "" ? 1 : 0

  name = var.root_domain
}

resource "aws_acm_certificate" "this" {
  count = var.root_domain != "" ? var.base_domain != "" ? 1 : 0 : 0

  domain_name = "*.${var.base_domain}"

  validation_method = "DNS"
}

resource "aws_route53_record" "this" {
  count = var.root_domain != "" ? var.base_domain != "" ? 1 : 0 : 0

  zone_id = data.aws_route53_zone.this[0].id
  name    = aws_acm_certificate.this[0].domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.this[0].domain_validation_options[0].resource_record_type
  ttl     = 60

  records = [
    aws_acm_certificate.this[0].domain_validation_options[0].resource_record_value,
  ]
}

resource "aws_acm_certificate_validation" "this" {
  count = var.root_domain != "" ? var.base_domain != "" ? 1 : 0 : 0

  certificate_arn = aws_acm_certificate.this[0].arn

  validation_record_fqdns = [
    aws_route53_record.this[0].fqdn,
  ]
}

output "acm_root" {
  value = var.root_domain
}

output "acm_base" {
  value = var.base_domain
}

output "acm_arn" {
  value = aws_acm_certificate.this.*.arn
}
