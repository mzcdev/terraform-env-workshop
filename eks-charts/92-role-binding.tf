# role_binding

resource "kubernetes_cluster_role_binding" "iam-developer-edit" {
  metadata {
    name = "iam:developer:edit"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "edit"
  }

  subject {
    kind = "User"
    name = "developer"
  }
}

resource "kubernetes_cluster_role_binding" "iam-readonly-view" {
  metadata {
    name = "iam:readonly:view"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view"
  }

  subject {
    kind = "User"
    name = "readonly"
  }
}
