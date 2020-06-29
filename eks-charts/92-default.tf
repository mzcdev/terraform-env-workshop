# default

resource "helm_release" "cluster-overprovisioner" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "cluster-overprovisioner"
  version    = var.stable_cluster_overprovisioner

  namespace = "default"
  name      = "cluster-overprovisioner"

  values = [
    file("./values/default/cluster-overprovisioner.yaml")
  ]

  wait = false

  # set {
  #   name  = "deployments.replicaCount"
  #   value = 0
  # }
}

# for jenkins
resource "kubernetes_config_map" "jenkins-env" {
  metadata {
    namespace = "default"
    name      = "jenkins-env"
  }

  data = {
    "groovy" = file("./values/default/env/jenkins-env.groovy")
  }
}
