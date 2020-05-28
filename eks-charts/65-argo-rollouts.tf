# argo-rollouts

resource "helm_release" "argo-rollouts" {
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-rollouts"
  version    = "0.3.0" # helm chart version argo/argo-rollouts

  namespace = "argo-rollouts"
  name      = "argo-rollouts"

  values = [
    file("./values/argo/argo-rollouts.yaml")
  ]

  create_namespace = true
}
