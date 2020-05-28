# argo

resource "helm_release" "argo" {
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo"
  version    = "0.9.3" # helm chart version argo/argo

  namespace = "argo"
  name      = "argo"

  values = [
    file("./values/argo/argo.yaml")
  ]

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.prometheus-operator,
  ]
}

resource "helm_release" "argo-gatekeeper" {
  repository = "https://gabibbo97.github.io/charts/"
  chart      = "keycloak-gatekeeper"
  version    = "3.3.0" # helm chart version gabibbo97/keycloak-gatekeeper

  namespace = "argo"
  name      = "argo-gatekeeper"

  values = [
    file("./values/argo/argo-gatekeeper.yaml")
  ]

  wait = false

  create_namespace = true
}
