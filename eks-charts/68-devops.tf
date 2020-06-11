# devops

resource "helm_release" "archiva" {
  repository = "https://xetus-oss.github.io/helm-charts/"
  chart      = "xetusoss-archiva"

  namespace = "devops"
  name      = "archiva"

  values = [
    file("./values/devops/archiva.yaml")
  ]

  set {
    name  = "persistence.storageClass"
    value = local.storage_class
  }

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.efs-provisioner,
  ]
}

resource "helm_release" "chartmuseum" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "chartmuseum"
  version    = "2.12.2" # helm chart version stable/chartmuseum

  namespace = "devops"
  name      = "chartmuseum"

  values = [
    file("./values/devops/chartmuseum.yaml")
  ]

  wait = false

  create_namespace = true
}

resource "helm_release" "docker-registry" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "docker-registry"
  version    = "1.9.3" # helm chart version stable/docker-registry

  namespace = "devops"
  name      = "docker-registry"

  values = [
    file("./values/devops/docker-registry.yaml")
  ]

  wait = false

  create_namespace = true
}

resource "helm_release" "jenkins" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "jenkins"
  version    = "2.0.1" # helm chart version stable/jenkins

  namespace = "devops"
  name      = "jenkins"

  values = [
    file("./values/devops/jenkins.yaml")
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

resource "kubernetes_cluster_role_binding" "cluster-admin-devops-default" {
  metadata {
    name = "cluster-admin:devops:default"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    namespace = "devops"
    name      = "default"
  }

  depends_on = [
    helm_release.jenkins,
  ]
}
