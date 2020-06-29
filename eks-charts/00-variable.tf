# variable

variable "region" {
  description = "생성될 리전을 입력 합니다. e.g: ap-northeast-2"
  default     = "ap-northeast-2"
}

variable "eks_name" {
  description = "EKS Cluster 이름을 입력합니다."
  default     = "eks-demo"
}

variable "host_name" {
  default = "*.demo.spic.me"
}

variable "slack_url" {
  default = "https://hooks.slack.com/services/REPLACEME/REPLACEME/REPLACEME"
}
