
data "aws_route53_zone" "this" {
  name = var.root_domain
}

data "aws_acm_certificate" "this" {
  count = var.acm_certificate ? 0 : 1

  domain = local.domain_name
  statuses = [
    "ISSUED",
  ]

  most_recent = true
}
