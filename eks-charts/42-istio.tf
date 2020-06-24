# istio

# istioctl manifest apply --set profile=demo --set values.kiali.dashboard.auth.strategy=anonymous

resource "helm_release" "kiali-gatekeeper" {
  repository = "https://gabibbo97.github.io/charts/"
  chart      = "keycloak-gatekeeper"
  version    = "3.3.1" # helm chart version gabibbo97/keycloak-gatekeeper

  namespace = "istio-system"
  name      = "kiali-gatekeeper"

  values = [
    file("./values/istio/kiali-gatekeeper.yaml")
  ]

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.keycloak,
  ]
}

resource "helm_release" "tracing-gatekeeper" {
  repository = "https://gabibbo97.github.io/charts/"
  chart      = "keycloak-gatekeeper"
  version    = "3.3.1" # helm chart version gabibbo97/keycloak-gatekeeper

  namespace = "istio-system"
  name      = "tracing-gatekeeper"

  values = [
    file("./values/istio/tracing-gatekeeper.yaml")
  ]

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.keycloak,
  ]
}
