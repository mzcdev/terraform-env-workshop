# data

data "aws_caller_identity" "current" {
}

data "aws_route53_zone" "this" {
  count = var.host_root != "" ? 1 : 0

  name = var.host_root
}
