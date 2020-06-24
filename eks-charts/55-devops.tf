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
  version    = "2.13.0" # helm chart version stable/chartmuseum

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
