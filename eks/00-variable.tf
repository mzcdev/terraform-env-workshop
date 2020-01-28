
variable "region" {
  description = "생성될 리전."
  type        = string
  default     = "ap-northeast-2"
}

variable "name" {
  description = "클러스터 이름."
  type        = string
  default     = "eks-demo"
}

variable "kubernetes_version" {
  description = "쿠버네티스 버전."
  type        = string
  default     = "1.14"
}

variable "allow_ip_address" {
  description = "List of IP Address to permit access"
  type        = list(string)
  default     = []
}

# variable "workers" {
#   description = "Additional IAM roles to add to the aws-auth configmap."
#   type        = list(string)
#   default     = [
#     "arn:aws:iam::${local.account_id}:role/${var.name}-worker",
#   ]
# }

# variable "map_roles" {
#   description = "Additional IAM roles to add to the aws-auth configmap."
#   type = list(object({
#     rolearn  = string
#     username = string
#     groups   = list(string)
#   }))
#   default = [
#     {
#       rolearn  = "arn:aws:iam::${local.account_id}:role/bastion"
#       username = "iam-role-bastion"
#       groups   = ["system:masters"]
#     },
#   ]
# }

# variable "map_users" {
#   description = "Additional IAM users to add to the aws-auth configmap."
#   type = list(object({
#     userarn  = string
#     username = string
#     groups   = list(string)
#   }))
#   default = [
#     {
#       userarn  = "arn:aws:iam::${local.account_id}:user/jungyoul.yu"
#       username = "jungyoul.yu"
#       groups   = ["system:masters"]
#     },
#     {
#       userarn  = "arn:aws:iam::${local.account_id}:user/developer"
#       username = "developer"
#       groups   = [""]
#     },
#   ]
# }

variable "instance_type" {
  default = "m5.large"
}

variable "mixed_instances" {
  type    = list(string)
  default = ["c5.large", "r5.large"]
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
