# logging

# resource "helm_release" "fluentd-elasticsearch" {
#   repository = "https://kiwigrid.github.io"
#   chart      = "fluentd-elasticsearch"
#   version    = var.kiwigrid_fluentd_elasticsearch

#   namespace = "logging"
#   name      = "fluentd-elasticsearch"

#   values = [
#     file("./values/logging/fluentd-elasticsearch.yaml")
#   ]

#   wait = false

#   create_namespace = true
# }
