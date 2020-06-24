# data

data "aws_caller_identity" "current" {
}

data "aws_eks_cluster" "cluster" {
  name = local.eks_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.aws_eks_cluster.cluster.name
}

# data "template_file" "kubeconfig" {
#   template = "${file(local.kube_template)}"
#   vars = {
#     cluster_url       = data.aws_eks_cluster.cluster.endpoint
#     cluster_auth_data = data.aws_eks_cluster.cluster.certificate_authority.0.data
#     cluster_token     = data.aws_eks_cluster_auth.cluster.token
#   }
# }
