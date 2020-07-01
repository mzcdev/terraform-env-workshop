# data

data "aws_caller_identity" "current" {
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.aws_eks_cluster.cluster.name
}

data "template_file" "jenkins-env" {
  template = file("${path.module}/template/jenkins-env.groovy")
  vars = {
    cluster     = var.cluster_name
    role        = var.cluster_role
    base_domain = var.base_domain
    slack_token = var.slack_token
    jenkins     = local.domain.jenkins
    harbor      = local.domain.harbor
    archiva     = local.domain.archiva
    chartmuseum = local.domain.chartmuseum
    registry    = local.domain.registry
    nexus       = local.domain.nexus
    sonarqube   = local.domain.sonarqube
  }
}

# data "template_file" "keycloak-realm" {
#   template = file("${path.module}/template/keycloak-realm.json")
#   vars = {
#     google_client_id     = var.google_client_id
#     google_client_secret = var.google_client_secret
#   }
# }

# data "template_file" "kube-config" {
#   template = file("${path.module}/template/kube-config.yaml")
#   vars = {
#     cluster_url       = data.aws_eks_cluster.cluster.endpoint
#     cluster_auth_data = data.aws_eks_cluster.cluster.certificate_authority.0.data
#     cluster_token     = data.aws_eks_cluster_auth.cluster.token
#   }
# }
