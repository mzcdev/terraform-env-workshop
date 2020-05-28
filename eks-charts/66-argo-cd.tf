# argo-cd

resource "helm_release" "argo-cd" {
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "2.3.4" # helm chart version argo/argo-cd

  namespace = "argo-cd"
  name      = "argocd"

  values = [
    file("./values/argo/argo-cd.yaml")
  ]

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.prometheus-operator,
    helm_release.argo-rollouts,
  ]
}
