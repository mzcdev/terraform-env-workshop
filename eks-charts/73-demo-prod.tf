# demo-prod

resource "kubernetes_namespace" "demo-prod" {
  metadata {
    labels = {
      istio-injection = "enabled"
    }

    name = "demo-prod"
  }
}

resource "helm_release" "demo-prod-http-benchmark" {
  repository = "https://kubernetes-charts-incubator.storage.googleapis.com"
  chart      = "raw"

  namespace = "demo-prod"
  name      = "http-benchmark"

  values = [
    file("./values/argo/http-benchmark.yaml")
  ]

  depends_on = [
    kubernetes_namespace.demo-prod,
    helm_release.argo-rollouts,
  ]
}
