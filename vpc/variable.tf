# variable

variable "region" {
  default = "ap-northeast-2"
}

variable "name" {
  default = "workshop"
}

variable "vpc_id" {
  default = ""
}

variable "vpc_cidr" {
  default = "10.15.0.0/16"
}

variable "public_subnets" {
  default = [
    {
      zone = "ap-northeast-2a"
      cidr = "10.15.1.0/24"
    },
    {
      zone = "ap-northeast-2b"
      cidr = "10.15.2.0/24"
    },
    {
      zone = "ap-northeast-2c"
      cidr = "10.15.3.0/24"
    },
  ]
}

variable "private_subnets" {
  default = [
    {
      zone = "ap-northeast-2a"
      cidr = "10.15.4.0/24"
    },
    {
      zone = "ap-northeast-2b"
      cidr = "10.15.5.0/24"
    },
    {
      zone = "ap-northeast-2c"
      cidr = "10.15.6.0/24"
    },
  ]
}

variable "tags" {
  default = {
    "kubernetes.io/cluster/workshop-eks" = "shared"
  }
}
