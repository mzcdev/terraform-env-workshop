
module "domain" {
  source = "../acm"

  domain_root = var.domain_root
  domain_name = var.domain_name
}
