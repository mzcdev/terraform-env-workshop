# data

data "aws_caller_identity" "current" {
}

data "aws_eks_cluster" "cluster" {
  name = local.eks_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.aws_eks_cluster.cluster.name
}
