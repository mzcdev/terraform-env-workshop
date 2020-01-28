
locals {
  account_id = data.aws_caller_identity.current.account_id
}

locals {
  workers = [
    "arn:aws:iam::${local.account_id}:role/${var.name}-worker",
  ]

  map_roles = [
    {
      rolearn  = "arn:aws:iam::${local.account_id}:role/bastion"
      username = "iam-role-bastion"
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
      groups   = [""]
    },
  ]
}

locals {
  user_data = <<EOF
#!/bin/bash -xe
/etc/eks/bootstrap.sh \
  --apiserver-endpoint '${aws_eks_cluster.cluster.endpoint}' \
  --b64-cluster-ca '${aws_eks_cluster.cluster.certificate_authority.0.data}' \
  '${var.name}'
EOF

}
