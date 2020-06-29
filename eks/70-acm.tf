# # acm

# data "aws_route53_zone" "this" {
#   count = var.host_root != "" ? 1 : 0

#   name = var.host_root
# }

# resource "aws_acm_certificate" "this" {
#   count = var.host_root != "" ? var.host_name != "" ? 1 : 0 : 0

#   domain_name = var.host_name

#   validation_method = "DNS"
# }

# resource "aws_route53_record" "this" {
#   count = var.host_root != "" ? var.host_name != "" ? 1 : 0 : 0

#   zone_id = data.aws_route53_zone.this[0].id
#   name    = aws_acm_certificate.this[0].domain_validation_options[0].resource_record_name
#   type    = aws_acm_certificate.this[0].domain_validation_options[0].resource_record_type
#   ttl     = 60

#   records = [
#     aws_acm_certificate.this[0].domain_validation_options[0].resource_record_value,
#   ]
# }

# resource "aws_acm_certificate_validation" "this" {
#   count = var.host_root != "" ? var.host_name != "" ? 1 : 0 : 0

#   certificate_arn = aws_acm_certificate.this[0].arn

#   validation_record_fqdns = [
#     aws_route53_record.this[0].fqdn,
#   ]
# }

# output "acm_host" {
#   value = var.host_name
# }

# output "acm_arn" {
#   value = aws_acm_certificate.this.*.arn
# }
