# # argo

# resource "helm_release" "argo" {
#   repository = "https://argoproj.github.io/argo-helm"
#   chart      = "argo"
#   version    = "0.9.5" # helm chart version argo/argo

#   namespace = "argo"
#   name      = "argo"

#   values = [
#     file("./values/argo/argo.yaml")
#   ]

#   wait = false

#   create_namespace = true

#   depends_on = [
#     helm_release.prometheus-operator,
#   ]
# }

# resource "helm_release" "argo-gatekeeper" {
#   repository = "https://gabibbo97.github.io/charts/"
#   chart      = "keycloak-gatekeeper"
#   version    = "3.3.1" # helm chart version gabibbo97/keycloak-gatekeeper

#   namespace = "argo"
#   name      = "argo-gatekeeper"

#   values = [
#     file("./values/argo/argo-gatekeeper.yaml")
#   ]

#   wait = false

#   create_namespace = true
# }

# resource "kubernetes_cluster_role_binding" "cluster-admin-argo-default" {
#   metadata {
#     name = "cluster-admin:argo:default"
#   }

#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "ClusterRole"
#     name      = "cluster-admin"
#   }

#   subject {
#     kind      = "ServiceAccount"
#     namespace = "argo"
#     name      = "default"
#   }

#   depends_on = [
#     helm_release.argo,
#   ]
# }
