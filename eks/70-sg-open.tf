# sg open

resource "aws_security_group" "open-elb" {
  count = var.host_root != "" ? var.host_open != "" ? 1 : 0 : 0

  name        = "${local.worker}-open-elb"
  description = "Security group for open-elb in the cluster"

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"                                = "${local.worker}-open-elb"
    "KubernetesCluster"                   = local.name
    "kubernetes.io/cluster/${local.name}" = "owned"
  }
}

resource "aws_security_group_rule" "open-elb-http" {
  count = var.host_root != "" ? var.host_open != "" ? 1 : 0 : 0

  description       = "Allow http to communicate with the open-elb http"
  security_group_id = aws_security_group.open-elb[0].id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  type              = "ingress"
}

resource "aws_security_group_rule" "open-elb-https" {
  count = var.host_root != "" ? var.host_open != "" ? 1 : 0 : 0

  description       = "Allow https to communicate with the open-elb https"
  security_group_id = aws_security_group.open-elb[0].id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  type              = "ingress"
}

output "elb-sg-open" {
  value = aws_security_group.open-elb.*.id
}
