# locals

locals {
  account_id = data.aws_caller_identity.current.account_id
}

locals {
  region = "ap-northeast-2" # data.terraform_remote_state.eks.outputs.region

  eks_name = data.terraform_remote_state.eks.outputs.eks_name

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
