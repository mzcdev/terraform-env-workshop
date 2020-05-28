# istio-demo

resource "kubernetes_namespace" "istio-demo" {
  metadata {
    labels = {
      istio-injection = "enabled"
    }

    name = "istio-demo"
  }
}
