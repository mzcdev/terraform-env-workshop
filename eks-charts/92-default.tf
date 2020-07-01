# default

resource "helm_release" "cluster-overprovisioner" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "cluster-overprovisioner"
  version    = var.stable_cluster_overprovisioner

  namespace = "default"
  name      = "cluster-overprovisioner"

  values = [
    file("./values/default/cluster-overprovisioner.yaml"),
    yamlencode(
      {
        deployments = [
          {
            name = "default"
            replicaCount = 0
            resources = {
              requests = {
                cpu = "1000m"
                memory = "1Gi"
              }
            }
          }
        ]
      }
    )
  ]

  # set {
  #   name  = "deployments.0.replicaCount"
  #   value = 1
  # }

  wait = false
}

# for jenkins
resource "kubernetes_config_map" "jenkins-env" {
  metadata {
    namespace = "default"
    name      = "jenkins-env"
  }

  data = {
    # "groovy" = file("${path.module}/template/jenkins-env.groovy")
    "groovy" = data.template_file.jenkins-env.rendered
  }
}
