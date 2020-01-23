
variable "region" {
  description = "생성될 리전을 입력 합니다."
  type        = string
  default     = "ap-northeast-2"
}

variable "name" {
  description = "서버 이름을 입력 합니다."
  type        = string
  default     = "bastion"
}

variable "vpc_id" {
  description = "생성될 VPC ID 를 입력 합니다."
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "생성될 Subnet ID 를 입력 합니다."
  type        = string
  default     = ""
}

variable "administrator" {
  description = "AdministratorAccess 권한 부여 여부를 입력 합니다."
  type        = bool
  default     = true
}

variable "allow_ip_address" {
  description = "SSH 로 접속 허용할 IP 목록을 입력 합니다."
  type        = list(string)
  default     = [
    "0.0.0.0/0"
  ]
}

variable "ami_id" {
  description = "Instance AMI ID 를 입력합니다. 입력하지 않으면 Amazon Linux 2 AMI 가 자동으로 입력 됩니다."
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "인스턴스 유형을 입력 합니다."
  type        = string
  default     = "t2.micro"
}

variable "volume_type" {
  description = "불륨 유형을 입력 합니다."
  type        = string
  default     = "gp2"
}

variable "volume_size" {
  description = "불륨 크기를 입력 합니다."
  type        = string
  default     = "8"
}

variable "key_name" {
  description = "키페어 이름을 입력 합니다."
  type        = string
  default     = "bastion"
}

variable "user_data" {
  description = "인스턴스 시작시 실핼될 스크립트를 입력 합니다."
  type        = string
  default     = ""
}
