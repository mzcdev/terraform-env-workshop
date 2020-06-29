# jenkins

resource "helm_release" "jenkins" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "jenkins"
  version    = var.stable_jenkins

  namespace = "jenkins"
  name      = "jenkins"

  values = [
    file("./values/jenkins/jenkins.yaml")
  ]

  set {
    name  = "persistence.storageClass"
    value = local.storage_class
  }

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.efs-provisioner,
    helm_release.prometheus-operator,
  ]
}

resource "kubernetes_cluster_role_binding" "cluster-admin-jenkins-default" {
  metadata {
    name = "cluster-admin:jenkins:default"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    namespace = "jenkins"
    name      = "default"
  }

  depends_on = [
    helm_release.jenkins,
  ]
}
