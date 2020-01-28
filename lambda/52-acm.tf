
module "domain" {
  source = "../acm"

  root_domain = var.root_domain
  domain_name = var.domain_name

  acm_certificate = true
}
