
module "domain" {
  source = "../acm"
  domain = var.domain_root
}
