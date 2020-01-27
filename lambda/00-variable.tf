
variable "region" {
  description = "생성될 리전."
  type        = string
  default     = "ap-northeast-2"
}

variable "name" {
  description = "서비스 이름."
  type        = string
  default     = "demo-api"
}

variable "stage" {
  description = "서비스 영역."
  type        = string
  default     = "dev"
}

variable "runtime" {
  description = "람다 펑션이 실행될 런타임."
  type        = string
  default     = "nodejs10.x"
}

variable "handler" {
  description = "람다 펑션이 실행될 핸들러 이름."
  type        = string
  default     = "index.handler"
}

variable "memory_size" {
  description = "람다 펑션이 실행될 메모리 사이즈."
  type        = string
  default     = "1024"
}

variable "timeout" {
  description = "람다 펑션의 타임아웃 값."
  type        = string
  default     = "5"
}

variable "s3_bucket" {
  description = "배포 패키지가 저장될 버켓 이름."
  type        = string
  default     = "terraform-workshop-seoul"
}

variable "s3_source" {
  description = "복사될 배포 패키지가 있는 경로."
  type        = string
  default     = "package/lambda.zip"
}

variable "s3_key" {
  description = "배포 패키지가 배포될 경로."
  type        = string
  default     = "package/lambda.zip"
}

variable "env_vars" {
  description = "람다 펑션에서 사용될 환경 변수 맵."
  type        = map(string)
  default = {
    "PROFILE" = "dev",
  }
}

variable "path_part" {
  description = "The last path segment of this API resource."
  type        = string
  default     = "{proxy+}"
}

variable "http_methods" {
  description = "The HTTP Methods (HEAD, DELETE, POST, GET, OPTIONS, PUT, PATCH)"
  type        = list(string)
  default = [
    "ANY",
  ]
}

variable "domain_root" {
  description = "Route53 에 등록된 도메인 명"
  type        = string
  default     = "mzdev.be"
}

variable "domain_name" {
  description = "람다 펑션이 서비스 될 도메인 명"
  type        = string
  default     = "demo-api.workshop.mzdev.be"
}
