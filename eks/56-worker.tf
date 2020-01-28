
resource "aws_launch_template" "worker" {
  name_prefix   = "${var.name}-worker-"
  image_id      = var.ami_id != "" ? var.ami_id : data.aws_ami.worker.id
  instance_type = var.instance_type
  user_data     = base64encode(var.user_data)

  key_name = var.key_path != "" ? var.name : var.key_name

  # ebs_optimized = var.ebs_optimized

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_type           = var.volume_type
      volume_size           = var.volume_size
      delete_on_termination = true
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.worker.name
  }

  monitoring {
    enabled = var.enable_monitoring
  }

  network_interfaces {
    delete_on_termination       = true
    associate_public_ip_address = var.associate_public_ip_address
    security_groups = concat(
      [aws_security_group.worker.id],
      var.security_groups,
    )
  }
}

resource "aws_autoscaling_group" "worker" {
  name = "${var.name}-worker"

  min_size = var.min
  max_size = var.max

  vpc_zone_identifier = data.terraform_remote_state.vpc.outputs.private_subnet_ids

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = var.on_demand_base
      on_demand_percentage_above_base_capacity = var.on_demand_rate
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.worker.id
        version            = "$Latest"
      }

      override {
        instance_type = var.instance_type
      }

      dynamic "override" {
        for_each = var.mixed_instances
        content {
          instance_type = override.value
        }
      }
    }
  }

  tags = concat(
    [
      {
        key                 = "Name"
        value               = "${var.name}-worker"
        propagate_at_launch = true
      },
      {
        key                 = "KubernetesCluster"
        value               = var.name
        propagate_at_launch = true
      },
      {
        key                 = "kubernetes.io/cluster/${var.name}"
        value               = "owned"
        propagate_at_launch = true
      },
      {
        key                 = "k8s.io/cluster-autoscaler/${var.name}"
        value               = "owned"
        propagate_at_launch = true
      },
      {
        key                 = "k8s.io/cluster-autoscaler/enabled"
        value               = "true"
        propagate_at_launch = true
      },
    ],
  )
}
