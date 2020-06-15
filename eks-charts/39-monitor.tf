# monitor

resource "helm_release" "grafana" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "grafana"
  version    = "5.1.4" # helm chart version stable/grafana

  namespace = "monitor"
  name      = "grafana"

  values = [
    file("./values/monitor/grafana.yaml")
  ]

  set {
    name  = "persistence.storageClassName"
    value = local.storage_class
  }

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.efs-provisioner,
  ]
}

resource "helm_release" "prometheus-adapter" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "prometheus-adapter"
  version    = "2.3.1" # helm chart version stable/prometheus-adapter

  namespace = "monitor"
  name      = "prometheus-adapter"

  values = [
    file("./values/monitor/prometheus-adapter.yaml")
  ]

  wait = false

  create_namespace = true
}

resource "helm_release" "prometheus-operator" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "prometheus-operator"
  version    = "8.14.0" # helm chart version stable/prometheus-operator

  namespace = "monitor"
  name      = "prometheus-operator"

  values = [
    file("./values/monitor/prometheus-operator.yaml")
  ]

  set {
    name  = "prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.storageClassName"
    value = local.storage_class
  }

  create_namespace = true

  depends_on = [
    helm_release.efs-provisioner,
  ]
}

resource "helm_release" "prometheus-alert-rules" {
  repository = "https://kubernetes-charts-incubator.storage.googleapis.com"
  chart      = "raw"

  namespace = "monitor"
  name      = "prometheus-alert-rules"

  values = [
    file("./values/monitor/prometheus-alert-rules.yaml")
  ]

  depends_on = [
    helm_release.prometheus-operator,
  ]
}

# resource "helm_release" "datadog" {
#   repository = "https://kubernetes-charts.storage.googleapis.com"
#   chart      = "datadog"
#   version    = "2.3.9" # helm chart version stable/datadog

#   namespace = "monitor"
#   name      = "datadog"

#   values = [
#     file("./values/monitor/datadog.yaml")
#   ]

#   wait = false

#   create_namespace = true

#   set {
#     name  = "datadog.apiKey"
#     value = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
#   }

#   set {
#     name  = "datadog.appKey"
#     value = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
#   }

#   set {
#     name  = "datadog.clusterName"
#     value = local.eks_name
#   }
# }
