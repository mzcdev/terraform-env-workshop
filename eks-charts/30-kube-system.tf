# kube-system

resource "helm_release" "cluster-autoscaler" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "cluster-autoscaler"
  version    = var.stable_cluster_autoscaler

  namespace = "kube-system"
  name      = "cluster-autoscaler"

  values = [
    file("./values/kube-system/cluster-autoscaler.yaml")
  ]

  wait = false

  set {
    name  = "awsRegion"
    value = var.region
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.eks_name
  }
}

resource "helm_release" "efs-provisioner" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "efs-provisioner"
  version    = var.stable_efs_provisioner

  namespace = "kube-system"
  name      = "efs-provisioner"

  values = [
    file("./values/kube-system/efs-provisioner.yaml")
  ]

  set {
    name  = "efsProvisioner.awsRegion"
    value = var.region
  }

  set {
    name  = "efsProvisioner.efsFileSystemId"
    value = local.efs_id
  }
}

resource "helm_release" "k8s-spot-termination-handler" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "k8s-spot-termination-handler"
  version    = var.stable_k8s_spot_termination_handler

  namespace = "kube-system"
  name      = "k8s-spot-termination-handler"

  values = [
    file("./values/kube-system/k8s-spot-termination-handler.yaml")
  ]

  wait = false

  set {
    name  = "clusterName"
    value = var.eks_name
  }

  set {
    name  = "slackUrl"
    value = var.slack_url
  }
}

resource "helm_release" "kube2iam" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "kube2iam"
  version    = var.stable_kube2iam

  namespace = "kube-system"
  name      = "kube2iam"

  values = [
    file("./values/kube-system/kube2iam.yaml")
  ]

  wait = false

  set {
    name  = "awsRegion"
    value = var.region
  }
}

resource "helm_release" "metrics-server" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "metrics-server"
  version    = var.stable_metrics_server

  namespace = "kube-system"
  name      = "metrics-server"

  values = [
    file("./values/kube-system/metrics-server.yaml")
  ]

  wait = false
}

# resource "helm_release" "kube-state-metrics" {
#   repository = "https://kubernetes-charts.storage.googleapis.com"
#   chart      = "kube-state-metrics"
#   version    = var.stable_kube_state_metrics

#   namespace = "kube-system"
#   name      = "kube-state-metrics"

#   wait = false

#   values = [
#     file("./values/kube-system/kube-state-metrics.yaml")
#   ]
# }
