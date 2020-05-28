# variable

variable "region" {
  description = "생성될 리전을 입력 합니다. e.g: ap-northeast-2"
  default     = "ap-northeast-2"
}

variable "name" {
  description = "VPC 이름을 입력합니다."
  default     = "vpc-demo"
}

variable "vpc_id" {
  description = "이미 만들어진 VPC 가 있으면 ID 를 입력 합니다.."
  default     = ""
}

variable "vpc_cidr" {
  description = "VPC 사이더를 입력합니다."
  default     = "10.10.0.0/16"
}

variable "single_route_table" {
  description = "Subnet 마다 Route Table 을 설정 할지 선택 합니다."
  default     = false
}

variable "enable_nat_gateway" {
  description = "Private Subnet 을 NAT Gateway 로 연결 할지 선택 합니다."
  default     = true
}

variable "single_nat_gateway" {
  description = "Private Subnet 마다 NAT Gateway 을 연결 할지 선택 합니다."
  default     = false
}

variable "public_subnets" {
  description = "생성될 공개 서브넷 목록을 입력합니다."
  # type = list(object({
  #   zone = string
  #   cidr = string
  #   tags = map
  # }))
  default = [
    {
      name = "public-a"
      zone = "ap-northeast-2a"
      cidr = "10.10.1.0/24"
      tags = {}
    },
    {
      name = "public-b"
      zone = "ap-northeast-2b"
      cidr = "10.10.2.0/24"
      tags = {}
    },
    {
      name = "public-c"
      zone = "ap-northeast-2c"
      cidr = "10.10.3.0/24"
      tags = {}
    },
  ]
}

variable "private_subnets" {
  description = "생성될 비공개 서브넷 목록을 입력합니다."
  # type = list(object({
  #   zone = string
  #   cidr = string
  #   tags = map
  # }))
  default = [
    {
      name = "private-a"
      zone = "ap-northeast-2a"
      cidr = "10.10.4.0/24"
      tags = {}
    },
    {
      name = "private-b"
      zone = "ap-northeast-2b"
      cidr = "10.10.5.0/24"
      tags = {}
    },
    {
      name = "private-c"
      zone = "ap-northeast-2c"
      cidr = "10.10.6.0/24"
      tags = {}
    },
  ]
}

variable "tags" {
  description = "생성되는 모든 리소스에 Tag 가 입력 됩니다."
  default = {
    "kubernetes.io/cluster/eks-demo" = "shared"
  }
}
