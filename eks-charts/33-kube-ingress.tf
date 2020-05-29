# kube-ingress

resource "helm_release" "cert-manager-issuers" {
  repository = "https://kubernetes-charts-incubator.storage.googleapis.com"
  chart      = "raw"

  namespace = "kube-ingress"
  name      = "cert-manager-issuers"

  values = [
    file("./values/kube-ingress/cert-manager-issuers.yaml")
  ]

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.cert-manager,
  ]
}

resource "helm_release" "cert-manager" {
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v0.15.0" # helm chart version jetstack/cert-manager

  namespace = "kube-ingress"
  name      = "cert-manager"

  values = [
    file("./values/kube-ingress/cert-manager.yaml")
  ]

  create_namespace = true
}

resource "helm_release" "external-dns" {
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  version    = "3.0.2" # helm chart version bitnami/external-dns

  namespace = "kube-ingress"
  name      = "external-dns"

  values = [
    file("./values/kube-ingress/external-dns.yaml")
  ]

  wait = false

  create_namespace = true
}

resource "helm_release" "nginx-ingress-closed" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "nginx-ingress"
  version    = "1.38.0" # helm chart version stable/nginx-ingress

  namespace = "kube-ingress"
  name      = "nginx-ingress-closed"

  values = [
    file("./values/kube-ingress/nginx-ingress-closed.yaml")
  ]

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.prometheus-operator,
  ]
}

resource "helm_release" "nginx-ingress-open" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "nginx-ingress"
  version    = "1.38.0" # helm chart version stable/nginx-ingress

  namespace = "kube-ingress"
  name      = "nginx-ingress-open"

  values = [
    file("./values/kube-ingress/nginx-ingress-open.yaml")
  ]

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.prometheus-operator,
  ]
}
