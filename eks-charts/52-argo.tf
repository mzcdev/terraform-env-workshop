# argo & argo-events

resource "helm_release" "argo" {
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo"
  version    = var.argo_argo

  namespace = "argo"
  name      = "argo"

  values = [
    file("./values/argo/argo.yaml")
  ]

  set {
    name  = "artifactRepository.s3.bucket"
    value = "${var.eks_name}-argo-${local.account_id}"
  }

  set {
    name  = "artifactRepository.s3.region"
    value = var.region
  }

  create_namespace = true

  depends_on = [
    helm_release.prometheus-operator,
  ]
}

# resource "helm_release" "argo-events" {
#   repository = "https://argoproj.github.io/argo-helm"
#   chart      = "argo-events"
#   version    = var.argo_argo_events

#   namespace = "argo-events"
#   name      = "argo-events"

#   values = [
#     file("./values/argo/argo-events.yaml")
#   ]

#   wait = false

#   create_namespace = true
# }

resource "helm_release" "argo-gatekeeper" {
  repository = "https://gabibbo97.github.io/charts/"
  chart      = "keycloak-gatekeeper"
  version    = var.gabibbo97_keycloak_gatekeeper

  namespace = "argo"
  name      = "argo-gatekeeper"

  values = [
    file("./values/argo/argo-gatekeeper.yaml")
  ]

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.argo,
    helm_release.keycloak,
  ]
}

resource "kubernetes_cluster_role_binding" "admin-argo-default" {
  metadata {
    name = "admin:argo:default"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "admin"
  }

  subject {
    kind      = "ServiceAccount"
    namespace = "argo"
    name      = "default"
  }

  depends_on = [
    helm_release.argo,
  ]
}

resource "kubernetes_cluster_role_binding" "edit-default-default" {
  metadata {
    name = "edit:default:default"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "edit"
  }

  subject {
    kind      = "ServiceAccount"
    namespace = "default"
    name      = "default"
  }
}
