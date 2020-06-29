# locals

locals {
  account_id = data.aws_caller_identity.current.account_id
}

locals {
  # acm_host = data.terraform_remote_state.eks.outputs.acm_host
  # acm_arn  = element(concat(data.terraform_remote_state.eks.outputs.acm_arn, [""]), 0)

  efs_id = element(concat(data.terraform_remote_state.eks.outputs.efs_ids, [""]), 0)

  storage_class = local.efs_id == "" ? "default" : "efs"
}

# locals {
#   kube_template = "${path.module}/template/kube-config.yaml"
# }

# resource "local_file" "kubeconfig" {
#   content  = data.template_file.kubeconfig.rendered
#   filename = "${path.module}/.kube/config"
# }
