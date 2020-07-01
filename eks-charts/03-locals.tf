# locals

locals {
  account_id = data.aws_caller_identity.current.account_id
}

locals {
  host_name = "*.${var.base_domain}"

  efs_id = element(concat(data.terraform_remote_state.eks.outputs.efs_ids, [""]), 0)

  storage_class = local.efs_id == "" ? "default" : "efs"

  slack_url = format("%s/%s", "https://hooks.slack.com/services", var.slack_token)
}

locals {
  domain = {
    jenkins     = var.jenkins_enabled ? "jenkins.${var.base_domain}" : ""
    archiva     = var.archiva_enabled ? "archiva.${var.base_domain}" : ""
    chartmuseum = var.chartmuseum_enabled ? "chartmuseum.${var.base_domain}" : ""
    registry    = var.registry_enabled ? "registry.${var.base_domain}" : ""
    harbor      = var.harbor_enabled ? "harbor-core.${var.base_domain}" : ""
    nexus       = var.nexus_enabled ? "nexus.${var.base_domain}" : ""
    sonarqube   = var.sonarqube_enabled ? "sonarqube.${var.base_domain}" : ""
  }
}

# resource "local_file" "kube-config" {
#   content  = data.template_file.kube-config.rendered
#   filename = "${path.module}/.kube/config"
# }
