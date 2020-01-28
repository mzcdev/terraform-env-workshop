
locals {
  account_id = data.aws_caller_identity.current.account_id
}

locals {
  user_data = <<EOF
#!/bin/bash -xe
/etc/eks/bootstrap.sh \
  --apiserver-endpoint '${var.cluster_endpoint}' \
  --b64-cluster-ca '${var.cluster_certificate_authority}' \
  '${var.cluster_name}'
EOF

}
