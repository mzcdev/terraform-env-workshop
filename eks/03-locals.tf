# locals

locals {
  account_id = data.aws_caller_identity.current.account_id
}

locals {
  name = "${var.name}"

  worker = "${local.name}-worker"

  workers = [
    "arn:aws:iam::${local.account_id}:role/${local.worker}",
  ]

  map_roles = [
    {
      rolearn  = "arn:aws:iam::${local.account_id}:role/dev-bastion"
      username = "iam-role-eks-bastion"
      groups   = ["system:masters"]
    },
  ]

  map_users = [
    {
      userarn  = "arn:aws:iam::${local.account_id}:user/jungyoul.yu"
      username = "jungyoul.yu"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::${local.account_id}:user/developer"
      username = "developer"
      groups   = []
    },
    {
      userarn  = "arn:aws:iam::${local.account_id}:user/readonly"
      username = "readonly"
      groups   = []
    },
  ]

  buckets = flatten([
    for bucket in var.buckets : [
      "${var.name}-${bucket}-${local.account_id}"
    ]
  ])
}
