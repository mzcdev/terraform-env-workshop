# kube-system

resource "helm_release" "cluster-autoscaler" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "cluster-autoscaler"
  version    = "7.3.2" # helm chart version stable/cluster-autoscaler

  namespace = "kube-system"
  name      = "cluster-autoscaler"

  values = [
    file("./values/kube-system/cluster-autoscaler.yaml")
  ]

  wait = false

  set {
    name  = "awsRegion"
    value = local.region
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = local.eks_name
  }
}

resource "helm_release" "efs-provisioner" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "efs-provisioner"
  version    = "0.11.1" # helm chart version stable/efs-provisioner

  namespace = "kube-system"
  name      = "efs-provisioner"

  values = [
    file("./values/kube-system/efs-provisioner.yaml")
  ]

  set {
    name  = "efsProvisioner.awsRegion"
    value = local.region
  }

  set {
    name  = "efsProvisioner.efsFileSystemId"
    value = local.efs_id
  }
}

resource "helm_release" "k8s-spot-termination-handler" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "k8s-spot-termination-handler"
  version    = "1.4.9" # helm chart version stable/k8s-spot-termination-handler

  namespace = "kube-system"
  name      = "k8s-spot-termination-handler"

  values = [
    file("./values/kube-system/k8s-spot-termination-handler.yaml")
  ]

  wait = false

  set {
    name  = "clusterName"
    value = local.eks_name
  }

  set {
    name  = "slackUrl"
    value = "https://hooks.slack.com/services/XXXXX/XXXXX/XXXXX"
  }
}

resource "helm_release" "kube2iam" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "kube2iam"
  version    = "2.5.0" # helm chart version stable/kube2iam

  namespace = "kube-system"
  name      = "kube2iam"

  values = [
    file("./values/kube-system/kube2iam.yaml")
  ]

  wait = false

  set {
    name  = "awsRegion"
    value = local.region
  }
}

resource "helm_release" "metrics-server" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "metrics-server"
  version    = "2.11.1" # helm chart version stable/metrics-server

  namespace = "kube-system"
  name      = "metrics-server"

  values = [
    file("./values/kube-system/metrics-server.yaml")
  ]

  wait = false
}
