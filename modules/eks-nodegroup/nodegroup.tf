resource "aws_launch_template" "node_group" {
  name                   = format("%s-%s-node-group-lt", var.cluster_name, local.tag_environment)
  update_default_version = true

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.disk_size
      volume_type = "gp3"
      encrypted   = var.node_kms_key_arn != "" ? var.volume_encryption : ""
      kms_key_id  = var.node_kms_key_arn != "" ? var.node_kms_key_arn : ""
    }
  }

  instance_type = var.instance_type

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      tomap({ "Name" = format("%s-%s-node-group", var.cluster_name, local.tag_environment) }),
      var.common_tags
    )

  }
}

resource "aws_eks_node_group" "workers" {
  cluster_name    = var.cluster_name
  capacity_type   = var.capacity_type
  node_group_name = "${var.cluster_name}-${local.tag_environment}"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.node_subnet_ids
  instance_types  = []
  labels          = var.labels

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_capacity
    min_size     = var.min_capacity
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  launch_template {
    id      = aws_launch_template.node_group.id
    version = aws_launch_template.node_group.latest_version
  }

  tags = {
    "k8s.io/cluster-autoscaler/enabled"             = "true"
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "true"
  }
}
