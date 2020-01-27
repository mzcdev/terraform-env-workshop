
variable "region" {
  description = "생성될 리전을 입력 합니다."
  type        = string
  default     = "ap-northeast-2"
}

variable "name" {
  description = "서비스 이름을 입력 합니다."
  type        = string
  default     = "demo-api"
}

variable "stage" {
  description = "서비스 영역을 입력 합니다."
  type        = string
  default     = "dev"
}

variable "runtime" {
  description = "람다 펑션이 실행될 런타임을 입력 합니다."
  type        = string
  default     = "nodejs10.x"
}

variable "handler" {
  description = "람다 펑션이 실행될 핸들러 이름을 입력 합니다."
  type        = string
  default     = "index.handler"
}

variable "memory_size" {
  description = "람다 펑션이 실행될 메모리 사이즈를 입력 합니다."
  type        = string
  default     = "1024"
}

variable "timeout" {
  description = "람다 펑션의 타임아웃 값을 입력 합니다."
  type        = string
  default     = "5"
}

variable "s3_bucket" {
  description = "The S3 bucket location containing the function's deployment package."
  type        = string
  default     = "terraform-workshop-seoul"
}

variable "s3_source" {
  description = "The S3 source location containing the function's deployment package."
  type        = string
  default     = "package/lambda.zip"
}

variable "s3_key" {
  description = "The S3 key of an object containing the function's deployment package."
  type        = string
  default     = "package/lambda.zip"
}

variable "env_vars" {
  description = "A map that defines environment variables for the Lambda function."
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
  description = ""
  type        = string
  default     = "mzdev.be"
}

variable "domain_name" {
  description = ""
  type        = string
  default     = "demo-api.workshop.mzdev.be"
}
