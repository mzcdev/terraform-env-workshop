# istio

variable "istio_vresion" {
  default = "1.5.4"
}

resource "helm_release" "kiali-gatekeeper" {
  repository = "https://gabibbo97.github.io/charts/"
  chart      = "keycloak-gatekeeper"
  version    = "3.3.0" # helm chart version gabibbo97/keycloak-gatekeeper

  namespace = "istio-system"
  name      = "kiali-gatekeeper"

  values = [
    file("./values/istio/kiali-gatekeeper.yaml")
  ]

  wait = false

  create_namespace = true
}

resource "helm_release" "tracing-gatekeeper" {
  repository = "https://gabibbo97.github.io/charts/"
  chart      = "keycloak-gatekeeper"
  version    = "3.3.0" # helm chart version gabibbo97/keycloak-gatekeeper

  namespace = "istio-system"
  name      = "tracing-gatekeeper"

  values = [
    file("./values/istio/tracing-gatekeeper.yaml")
  ]

  wait = false

  create_namespace = true
}

# resource "helm_release" "istio-init" {
#   repository = "https://storage.googleapis.com/istio-release/releases/${var.istio_vresion}/charts/"
#   chart      = "istio-init"
#   version    = var.istio_vresion

#   namespace = "istio-system"
#   name      = "istio-init"

#   values = [
#     file("./values/istio/istio-init.yaml")
#   ]

#   create_namespace = true
# }

# resource "helm_release" "istio" {
#   repository = "https://storage.googleapis.com/istio-release/releases/${var.istio_vresion}/charts/"
#   chart      = "istio"
#   version    = var.istio_vresion

#   namespace = "istio-system"
#   name      = "istio"

#   values = [
#     file("./values/istio/istio-demo.yaml")
#   ]

#   wait = false

#   create_namespace = true
# }
