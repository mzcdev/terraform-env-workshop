# variable

variable "region" {
  description = "생성될 리전을 입력 합니다. e.g: ap-northeast-2"
  default     = "ap-northeast-2"
}

variable "name" {
  description = "EKS 이름을 입력합니다."
  default     = "eks-demo"
}

variable "kubernetes_version" {
  description = "쿠버네티스 버전을 입력합니다."
  default     = "1.16"
}

variable "cluster_log_types" {
  description = "CloudWatch 로그를 설정 합니다."
  default     = ["api", "audit", "authenticator"]
  # api, audit, authenticator, controllerManager, scheduler
}

variable "cluster_log_retention_in_days" {
  description = "로그 저장 기간을 입력 합니다."
  default     = 14
}

variable "allow_ip_address" {
  description = "접속 허용 IP 목록을 입력 합니다."
  default = [
    "10.10.1.0/24",     # bastion
    "211.60.50.190/32", # echo "$(curl -sL icanhazip.com)/32"
  ]
}

variable "launch_configuration_enable" {
  description = "Launch Configuration 을 생성 할지 선택 합니다."
  default     = false
}

variable "launch_template_enable" {
  description = "Launch Template 을 생성 할지 선택 합니다."
  default     = true
}

variable "launch_each_subnet" {
  description = "모든 Subnet 에 생성 할지 선택 합니다."
  default     = false
}

variable "associate_public_ip_address" {
  description = "공개 IP 를 생성 할지 선택 합니다."
  default     = false
}

variable "instance_type" {
  description = "워커 노드 인스턴스 타입"
  default     = "m5.xlarge"
}

variable "mixed_instances" {
  description = "워커 노드 추가 인스턴스 타입 목록"
  default     = ["c5.xlarge", "r5.xlarge"]
}

variable "volume_type" {
  default = "gp2"
}

variable "volume_size" {
  default = "32"
}

variable "min" {
  default = "1"
}

variable "max" {
  default = "5"
}

variable "on_demand_base" {
  default = "0"
}

variable "on_demand_rate" {
  default = "0"
}

variable "key_name" {
  description = "키페어 이름을 입력 합니다."
  default     = "nalbam-seoul"
}

variable "key_path" {
  default = ""
}

variable "buckets" {
  description = "S3 Bucket 을 생성 한다면 목록으로 입력 합니다."
  default = [
    "eks-demo-argo-demo",
    "eks-demo-chartmuseum-demo",
    "eks-demo-registry-demo",
    "eks-demo-vault-demo",
    "eks-demo-harbor-demo",
  ]
}

variable "launch_efs_enable" {
  description = "EFS 스토리지를 생성 할지 선택 합니다."
  default     = true
}

variable "host_root" {
  default = "mzdev.be"
}

variable "host_open" {
  default = "*.demo.mzdev.be"
}
