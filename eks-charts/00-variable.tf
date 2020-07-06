# variable

variable "region" {
  description = "생성될 리전을 입력 합니다. e.g: ap-northeast-2"
  default     = "ap-northeast-2"
}

variable "cluster_name" {
  description = "EKS Cluster 이름을 입력합니다. e.g: eks-demo"
  default     = "eks-demo"
}

variable "cluster_role" {
  description = "EKS Cluster 롤을 입력합니다. e.g: dev, stg, prod, devops"
  default     = "devops"
}

variable "admin_username" {
  default = "me@nalbam.com"
}

variable "admin_password" {
  default = "Kw7sM9oEE02fA6YiA55EqVpa"
}

variable "root_domain" {
  default = "mzdev.be"
}

variable "base_domain" {
  default = "demo.mzdev.be"
}

variable "slack_token" {
  default = "SLACK_TOKEN"
}

# variable "google_client_id" {
#   default = "REPLACEME.apps.googleusercontent.com"
# }

# variable "google_client_secret" {
#   default = "REPLACEME"
# }

# variable "datadog_api_key" {
#   default = "REPLACEME"
# }

# variable "datadog_app_key" {
#   default = "REPLACEME"
# }

variable "jenkins_enabled" {
  default = true
}

variable "chartmuseum_enabled" {
  default = true
}

variable "registry_enabled" {
  default = true
}

variable "harbor_enabled" {
  default = false
}

variable "archiva_enabled" {
  default = false
}

variable "nexus_enabled" {
  default = false
}

variable "sonarqube_enabled" {
  default = false
}
