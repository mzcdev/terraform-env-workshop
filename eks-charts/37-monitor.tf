# monitor

resource "helm_release" "grafana" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "grafana"
  version    = var.stable_grafana

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
  version    = var.stable_prometheus_adapter

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
  version    = var.stable_prometheus_operator

  namespace = "monitor"
  name      = "prometheus-operator"

  values = [
    file("./values/monitor/prometheus-operator.yaml")
  ]

  set {
    name  = "prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.storageClassName"
    value = local.storage_class
  }

  set {
    name  = "alertmanager.config.global.slack_api_url"
    value = "https://hooks.slack.com/services/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"
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

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.prometheus-operator,
  ]
}

# resource "helm_release" "datadog" {
#   repository = "https://kubernetes-charts.storage.googleapis.com"
#   chart      = "datadog"
#   version    = var.stable_datadog

#   namespace = "monitor"
#   name      = "datadog"

#   values = [
#     file("./values/monitor/datadog.yaml")
#   ]

#   wait = false

#   create_namespace = true

#   set {
#     name  = "datadog.apiKey"
#     value = "REPLACEME"
#   }

#   set {
#     name  = "datadog.appKey"
#     value = "REPLACEME"
#   }

#   set {
#     name  = "datadog.clusterName"
#     value = var.eks_name
#   }
# }
