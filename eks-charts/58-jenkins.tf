# jenkins

resource "kubernetes_namespace" "jenkins" {
  count = var.cluster_role == "devops" ? var.jenkins_enabled ? 1 : 0 : 0

  metadata {
    name = "jenkins"
  }
}

resource "helm_release" "jenkins" {
  count = var.cluster_role == "devops" ? var.jenkins_enabled ? 1 : 0 : 0

  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "jenkins"
  version    = var.stable_jenkins

  namespace = "jenkins"
  name      = "jenkins"

  values = [
    file("./values/jenkins/jenkins.yaml")
  ]

  set {
    name  = "master.adminUser"
    value = var.admin_username
  }

  set {
    name  = "master.adminPassword"
    value = var.admin_password
  }

  set {
    name  = "persistence.storageClass"
    value = local.storage_class
  }

  wait = false

  depends_on = [
    kubernetes_namespace.jenkins,
    helm_release.efs-provisioner,
    helm_release.prometheus-operator,
  ]
}

resource "kubernetes_cluster_role_binding" "cluster-admin-jenkins-default" {
  count = var.cluster_role == "devops" ? var.jenkins_enabled ? 1 : 0 : 0

  metadata {
    name = "cluster-admin:jenkins:default"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    namespace = "jenkins"
    name      = "default"
  }

  depends_on = [
    helm_release.jenkins,
  ]
}

# https://github.com/jenkinsci/kubernetes-credentials-provider-plugin/tree/master/docs/examples

resource "kubernetes_secret" "jenkins-secret-username" {
  count = var.cluster_role == "devops" ? var.jenkins_enabled ? 1 : 0 : 0

  metadata {
    namespace = "jenkins"
    name      = "jenkins-secret-username"

    labels = {
      "jenkins.io/credentials-type" : "usernamePassword"
    }

    annotations = {
      "jenkins.io/credentials-description" : "credentials from Kubernetes"
    }
  }

  type = "Opaque"

  data = {
    "username" = "username"
    "password" = "password"
  }

  depends_on = [
    helm_release.jenkins,
  ]
}

resource "kubernetes_secret" "jenkins-secret-text" {
  count = var.cluster_role == "devops" ? var.jenkins_enabled ? 1 : 0 : 0

  metadata {
    namespace = "jenkins"
    name      = "jenkins-secret-text"

    labels = {
      "jenkins.io/credentials-type" : "secretText"
    }

    annotations = {
      "jenkins.io/credentials-description" : "secret text credential from Kubernetes"
    }
  }

  type = "Opaque"

  data = {
    "text" = "Hello World!"
  }

  depends_on = [
    helm_release.jenkins,
  ]
}

resource "kubernetes_secret" "jenkins-secret-file" {
  count = var.cluster_role == "devops" ? var.jenkins_enabled ? 1 : 0 : 0

  metadata {
    namespace = "jenkins"
    name      = "jenkins-secret-file"

    labels = {
      "jenkins.io/credentials-type" : "secretFile"
    }

    annotations = {
      "jenkins.io/credentials-description" : "secret file credential from Kubernetes"
    }
  }

  type = "Opaque"

  data = {
    "filename" = "secret.txt"
    "data"     = file("./values/jenkins/secret/secret.txt")
  }

  depends_on = [
    helm_release.jenkins,
  ]
}

resource "kubernetes_secret" "jenkins-secret-private-key" {
  count = var.cluster_role == "devops" ? var.jenkins_enabled ? 1 : 0 : 0

  metadata {
    namespace = "jenkins"
    name      = "jenkins-secret-private-key"

    labels = {
      "jenkins.io/credentials-type" : "basicSSHUserPrivateKey"
    }

    annotations = {
      "jenkins.io/credentials-description" : "basic user private key credential from Kubernetes"
    }
  }

  type = "Opaque"

  data = {
    "username"   = "jenkins"
    "privateKey" = file("./values/jenkins/secret/jenkins.txt")
  }

  depends_on = [
    helm_release.jenkins,
  ]
}
