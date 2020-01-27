
output "zone_id" {
  value = data.aws_route53_zone.this.id
}

output "name" {
  value = data.aws_route53_zone.this.name
}

output "certificate_id" {
  value = aws_acm_certificate.cert.id
}

output "certificate_arn" {
  value = aws_acm_certificate.cert.arn
}
