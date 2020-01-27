
variable "region" {
  description = "생성될 리전."
  type        = string
  default     = "us-east-1"
}

variable "domain_root" {
  description = "Route53 에 등록된 도메인 명"
  type        = string
  default     = "mzdev.be"
}

variable "domain_name" {
  description = "ACM 인증서를 생성할 도메인 명"
  type        = string
  default     = "demo-api-workshop.mzdev.be"
}
