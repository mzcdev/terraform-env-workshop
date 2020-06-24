# demo-dev

resource "kubernetes_namespace" "demo-dev" {
  metadata {
    labels = {
      istio-injection = "enabled"
    }

    name = "demo-dev"
  }
}

# for argo-rollouts
resource "helm_release" "demo-dev-http-benchmark" {
  repository = "https://kubernetes-charts-incubator.storage.googleapis.com"
  chart      = "raw"

  namespace = "demo-dev"
  name      = "http-benchmark"

  values = [
    file("./values/argo/http-benchmark.yaml")
  ]

  depends_on = [
    kubernetes_namespace.demo-dev,
    helm_release.argo-rollouts,
  ]
}
