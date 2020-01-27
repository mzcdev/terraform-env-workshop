
resource "aws_acm_certificate" "cert" {
  domain_name = var.domain

  subject_alternative_names = [
    "*.${var.domain}"
  ]

  validation_method = "DNS"
}

resource "aws_route53_record" "cert" {
  zone_id = data.aws_route53_zone.this.id

  name = aws_acm_certificate.cert.domain_validation_options[0].resource_record_name
  type = aws_acm_certificate.cert.domain_validation_options[0].resource_record_type
  ttl  = 60

  records = [
    aws_acm_certificate.cert.domain_validation_options[0].resource_record_value,
  ]
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = aws_acm_certificate.cert.arn

  validation_record_fqdns = [
    aws_route53_record.cert.fqdn,
  ]
}
