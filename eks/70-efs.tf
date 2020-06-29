# efs

resource "aws_efs_file_system" "this" {
  count = var.launch_efs_enable ? 1 : 0

  creation_token = local.worker

  tags = {
    "Name"                                = local.worker
    "KubernetesCluster"                   = local.name
    "kubernetes.io/cluster/${local.name}" = "owned"
  }
}

resource "aws_efs_mount_target" "this" {
  count = var.launch_efs_enable ? length(data.terraform_remote_state.vpc.outputs.private_subnet_ids) : 0

  file_system_id = aws_efs_file_system.this[0].id

  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnet_ids[count.index]

  security_groups = [aws_security_group.worker-efs[0].id]
}

resource "aws_security_group" "worker-efs" {
  count = var.launch_efs_enable ? 1 : 0

  name        = "${local.worker}-efs"
  description = "Security group for efs in the cluster"

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"                                = "${local.worker}-efs"
    "KubernetesCluster"                   = local.name
    "kubernetes.io/cluster/${local.name}" = "owned"
  }
}

resource "aws_security_group_rule" "worker-efs" {
  count = var.launch_efs_enable ? 1 : 0

  description              = "Allow worker to communicate with efs"
  security_group_id        = aws_security_group.worker-efs[0].id
  source_security_group_id = module.worker.security_group_id
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "-1"
  type                     = "ingress"
}

output "efs_ids" {
  value = aws_efs_file_system.this.*.id
}
