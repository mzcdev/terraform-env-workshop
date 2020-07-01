# eks

module "eks" {
  source = "github.com/mzcdev/terraform-aws-eks?ref=v0.12.50"
  # source = "../../../terraform-aws-eks"

  region = var.region
  name   = local.name

  kubernetes_version = var.kubernetes_version

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids

  cluster_log_types             = var.cluster_log_types
  cluster_log_retention_in_days = var.cluster_log_retention_in_days

  allow_ip_address = var.allow_ip_address

  workers = local.workers

  map_roles = local.map_roles
  map_users = local.map_users

  tags = {}
}
