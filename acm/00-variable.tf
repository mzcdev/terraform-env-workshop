
variable "region" {
  description = "생성될 리전."
  type        = string
  default     = "us-east-1"
}

variable "root_domain" {
  description = "Route53 에 등록된 루트 도메인 명"
  type        = string
  default     = "mzdev.be"
}

variable "domain_name" {
  description = "ACM 인증서를 생성할 도메인 명"
  type        = string
  default     = "demo-api-workshop.mzdev.be"
}

variable "acm_certificate" {
  description = "ACM 인증서 생성 여부"
  type        = bool
  default     = false
}
