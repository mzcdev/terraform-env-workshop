# logging

# resource "helm_release" "fluentd-elasticsearch" {
#   repository = "https://kiwigrid.github.io"
#   chart      = "fluentd-elasticsearch"
#   version    = "9.3.2" # helm chart version kiwigrid/fluentd-elasticsearch

#   namespace = "logging"
#   name      = "fluentd-elasticsearch"

#   values = [
#     file("./values/logging/fluentd-elasticsearch.yaml")
#   ]

#   wait = false

#   create_namespace = true
# }
