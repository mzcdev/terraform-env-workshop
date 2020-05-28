# sg closed

resource "aws_security_group" "closed-elb" {
  count = var.host_root != "" ? var.host_closed != "" ? 1 : 0 : 0

  name        = "${local.worker}-closed-elb"
  description = "Security group for closed-elb in the cluster"

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"                                = "${local.worker}-closed-elb"
    "KubernetesCluster"                   = local.name
    "kubernetes.io/cluster/${local.name}" = "owned"
  }
}

resource "aws_security_group_rule" "closed-elb-http" {
  count = var.host_root != "" ? var.host_closed != "" ? 1 : 0 : 0

  description       = "Allow http to communicate with the closed-elb http"
  security_group_id = aws_security_group.closed-elb[0].id
  cidr_blocks       = var.allow_ip_address
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  type              = "ingress"
}

resource "aws_security_group_rule" "closed-elb-https" {
  count = var.host_root != "" ? var.host_closed != "" ? 1 : 0 : 0

  description       = "Allow https to communicate with the closed-elb https"
  security_group_id = aws_security_group.closed-elb[0].id
  cidr_blocks       = var.allow_ip_address
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  type              = "ingress"
}

resource "aws_security_group_rule" "closed-elb-self" {
  count = var.host_root != "" ? var.host_closed != "" ? length(local.nat_gateway_ips) : 0 : 0

  description       = "Allow https to communicate with the closed-elb self"
  security_group_id = aws_security_group.closed-elb[0].id
  cidr_blocks       = [format("%s/32", local.nat_gateway_ips[count.index])]
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  type              = "ingress"
}

output "elb-sg-closed" {
  value = aws_security_group.closed-elb.*.id
}
