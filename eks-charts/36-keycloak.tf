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
    "demo.json" = file("${path.module}/template/keycloak-realm.json")
    # "demo.json" = data.template_file.keycloak-realm.rendered
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
    name  = "keycloak.replicas"
    value = 2
  }

  set {
    name  = "keycloak.username"
    value = var.admin_username
  }

  set {
    name  = "keycloak.password"
    value = var.admin_password
  }

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
