# output

output "region" {
  value = var.region
}

output "eks_name" {
  value = module.eks.name
}

output "eks_version" {
  value = module.eks.version
}

output "eks_endpoint" {
  value = module.eks.endpoint
}

# output "eks_certificate_authority" {
#   value = module.eks.certificate_authority
# }

# output "eks_token" {
#   value = module.eks.token
# }

output "eks_oidc_issuer" {
  value = module.eks.oidc_issuer
}

output "eks_oidc_issuer_arn" {
  value = module.eks.oidc_issuer_arn
}

output "eks_iam_role_arn" {
  value = module.eks.iam_role_arn
}

output "eks_iam_role_name" {
  value = module.eks.iam_role_name
}

output "eks_security_group_id" {
  value = module.eks.security_group_id
}

output "worker_iam_role_arn" {
  value = module.worker.iam_role_arn
}

output "worker_iam_role_name" {
  value = module.worker.iam_role_name
}

output "worker_security_group_id" {
  value = module.worker.security_group_id
}

output "update_kubeconfig" {
  value = "aws eks update-kubeconfig --name ${module.eks.name} --alias ${module.eks.name}"
}
