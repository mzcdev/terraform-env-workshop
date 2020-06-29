# argo-cd & argo-rollouts

resource "helm_release" "argo-rollouts" {
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-rollouts"
  version    = var.argo_argo_rollouts

  namespace = "argo-rollouts"
  name      = "argo-rollouts"

  values = [
    file("./values/argo/argo-rollouts.yaml")
  ]

  create_namespace = true
}

resource "helm_release" "argo-cd" {
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argo_argo_cd

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
