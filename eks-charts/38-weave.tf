# weave-scope

resource "helm_release" "weave-scope" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "weave-scope"
  version    = "1.1.10" # helm chart version stable/weave-scope

  namespace = "weave"
  name      = "weave-scope"

  values = [
    file("./values/weave/weave-scope.yaml")
  ]

  wait = false

  create_namespace = true
}

resource "helm_release" "weave-scope-gatekeeper" {
  repository = "https://gabibbo97.github.io/charts/"
  chart      = "keycloak-gatekeeper"
  version    = "3.3.1" # helm chart version gabibbo97/keycloak-gatekeeper

  namespace = "weave"
  name      = "weave-scope-gatekeeper"

  values = [
    file("./values/weave/weave-scope-gatekeeper.yaml")
  ]

  wait = false

  create_namespace = true
}
