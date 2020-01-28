
locals {
  domain_name = var.domain_name == "" ? var.root_domain : var.domain_name
}

locals {
  certificate_id  = var.acm_certificate ? element(concat(aws_acm_certificate.cert.*.id, [""]), 0) : element(concat(data.aws_acm_certificate.this.*.id, [""]), 0)
  certificate_arn = var.acm_certificate ? element(concat(aws_acm_certificate.cert.*.arn, [""]), 0) : element(concat(data.aws_acm_certificate.this.*.arn, [""]), 0)
}
