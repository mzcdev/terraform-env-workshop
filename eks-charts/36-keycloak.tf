# keycloak

resource "kubernetes_namespace" "keycloak" {
  metadata {
    name = "keycloak"
  }
}

resource "kubernetes_secret" "keycloak-realm" {
  metadata {
    namespace = "keycloak"
    name      = "realm-demo-secret"
  }

  type = "Opaque"

  data = {
    "demo.json" = file("./values/keycloak/realm/demo.json")
  }

  depends_on = [
    kubernetes_namespace.keycloak,
  ]
}

resource "helm_release" "keycloak" {
  repository = "https://codecentric.github.io/helm-charts"
  chart      = "keycloak"
  version    = var.codecentric_keycloak

  namespace = "keycloak"
  name      = "keycloak"

  values = [
    file("./values/keycloak/keycloak.yaml")
  ]

  set {
    name  = "postgresql.persistence.storageClass"
    value = local.storage_class
  }

  depends_on = [
    kubernetes_secret.keycloak-realm,
    helm_release.efs-provisioner,
    helm_release.prometheus-operator,
  ]
}
