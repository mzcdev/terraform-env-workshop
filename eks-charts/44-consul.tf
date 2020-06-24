# consul

# resource "helm_release" "consul" {
#   repository = "https://kubernetes-charts.storage.googleapis.com"
#   chart      = "consul"
#   version    = "3.9.5" # helm chart version stable/consul

#   namespace = "consul"
#   name      = "consul"

#   values = [
#     file("./values/consul/consul.yaml")
#   ]

#   # wait = false

#   create_namespace = true

#   set {
#     name  = "StorageClass"
#     value = local.storage_class
#   }

#   depends_on = [
#     helm_release.efs-provisioner,
#   ]
# }

# resource "helm_release" "consul-gatekeeper" {
#   repository = "https://gabibbo97.github.io/charts/"
#   chart      = "keycloak-gatekeeper"
#   version    = "3.3.1" # helm chart version gabibbo97/keycloak-gatekeeper

#   namespace = "consul"
#   name      = "consul-gatekeeper"

#   values = [
#     file("./values/consul/consul-gatekeeper.yaml")
#   ]

#   wait = false

#   create_namespace = true

#   depends_on = [
#     helm_release.consul,
#     helm_release.keycloak,
#   ]
# }
