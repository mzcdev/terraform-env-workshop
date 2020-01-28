
variable "region" {
  description = "생성될 리전"
  type        = string
  default     = "ap-northeast-2"
}

variable "name" {
  description = "클러스터 이름"
  type        = string
  default     = "eks-demo"
}

variable "kubernetes_version" {
  description = "쿠버네티스 버전"
  type        = string
  default     = "1.14"
}

variable "allow_ip_address" {
  description = "접속 허용 IP 목록"
  type        = list(string)
  default     = []
}

variable "instance_type" {
  description = "워커 노드 인스턴스 타입"
  type        = string
  default     = "m5.large"
}

variable "mixed_instances" {
  description = "워커 노드 추가 인스턴스 타입 목록"
  type        = list(string)
  default     = ["c5.large", "r5.large"]
}

variable "enable_monitoring" {
  default = true
}

variable "ebs_optimized" {
  default = true
}

variable "volume_type" {
  default = "gp2"
}

variable "volume_size" {
  default = "32"
}

variable "min" {
  default = "2"
}

variable "max" {
  default = "5"
}

variable "on_demand_base" {
  default = "1"
}

variable "on_demand_rate" {
  default = "30"
}

variable "key_name" {
  description = "키페어 이름을 입력 합니다."
  type        = string
  default     = "nalbam-seoul"
}
