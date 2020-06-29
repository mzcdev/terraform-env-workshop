# devops

resource "helm_release" "chartmuseum" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "chartmuseum"
  version    = var.stable_chartmuseum

  namespace = "devops"
  name      = "chartmuseum"

  values = [
    file("./values/devops/chartmuseum.yaml")
  ]

  set {
    name  = "env.open.STORAGE_AMAZON_BUCKET"
    value = "${var.eks_name}-chartmuseum-${local.account_id}"
  }

  set {
    name  = "env.open.STORAGE_AMAZON_REGION"
    value = var.region
  }

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.efs-provisioner,
  ]
}

resource "helm_release" "docker-registry" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "docker-registry"
  version    = var.stable_docker_registry

  namespace = "devops"
  name      = "docker-registry"

  values = [
    file("./values/devops/docker-registry.yaml")
  ]

  set {
    name  = "s3.bucket"
    value = "${var.eks_name}-chartmuseum-${local.account_id}"
  }

  set {
    name  = "s3.region"
    value = var.region
  }

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.efs-provisioner,
  ]
}

# resource "helm_release" "archiva" {
#   repository = "https://xetus-oss.github.io/helm-charts/"
#   chart      = "xetusoss-archiva"

#   namespace = "devops"
#   name      = "archiva"

#   values = [
#     file("./values/devops/archiva.yaml")
#   ]

#   set {
#     name  = "persistence.storageClass"
#     value = local.storage_class
#   }

#   wait = false

#   create_namespace = true

#   depends_on = [
#     helm_release.efs-provisioner,
#   ]
# }

# resource "helm_release" "sonarqube" {
#   repository = "https://oteemo.github.io/charts"
#   chart      = "sonarqube"
#   version    = var.oteemo_sonarqube

#   namespace = "devops"
#   name      = "sonarqube"

#   values = [
#     file("./values/devops/sonarqube.yaml")
#   ]

#   set {
#     name  = "persistence.storageClass"
#     value = local.storage_class
#   }

#   set {
#     name  = "postgresql.persistence.storageClass"
#     value = local.storage_class
#   }

#   wait = false

#   create_namespace = true

#   depends_on = [
#     helm_release.efs-provisioner,
#   ]
# }

# resource "helm_release" "sonatype-nexus" {
#   repository = "https://oteemo.github.io/charts"
#   chart      = "sonatype-nexus"
#   version    = var.oteemo_sonatype_nexus

#   namespace = "devops"
#   name      = "sonatype-nexus"

#   values = [
#     file("./values/devops/sonatype-nexus.yaml")
#   ]

#   set {
#     name  = "persistence.storageClass"
#     value = local.storage_class
#   }

#   wait = false

#   create_namespace = true

#   depends_on = [
#     helm_release.efs-provisioner,
#   ]
# }
