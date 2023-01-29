data "aws_iam_policy_document" "worker_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "worker" {
  name               = "${var.cluster_name}-${local.tag_environment}-worker-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.worker_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "worker_eks_worker_node_policy" {
  role       = aws_iam_role.worker.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# https://docs.aws.amazon.com/eks/latest/userguide/create-node-role.html
resource "aws_iam_role_policy_attachment" "worker_eks_cni_policy" {
  role       = aws_iam_role.worker.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "worker_ec2_container_registry_read_only" {
  role       = aws_iam_role.worker.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "worker_ec2_ebs_csi_policy" {
  role       = aws_iam_role.worker.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

resource "aws_iam_role_policy_attachment" "worker_role_cw_logs_policy" {
  role       = aws_iam_role.worker.name
  policy_arn = aws_iam_policy.cw_logs_writer.arn
}

data "aws_iam_policy_document" "worker_sts_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    resources = ["*"]
  }
}

resource "aws_iam_policy" "allow_all_sts" {
  name   = "${var.cluster_name}-${local.tag_environment}-worker-sts"
  policy = data.aws_iam_policy_document.worker_sts_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "worker_allow_all_sts" {
  role       = aws_iam_role.worker.name
  policy_arn = aws_iam_policy.allow_all_sts.arn
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.cluster_name}-${local.tag_environment}-worker-profile"
  role = aws_iam_role.worker.name
}

data "aws_iam_policy_document" "eks_autoscaling_policy" {
  statement {
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "ec2:DescribeLaunchTemplateVersions",
      "eks:DescribeNodegroup"
    ]

    resources = [
      "*"
    ]

    effect = "Allow"
  }
}

resource "aws_iam_policy" "eks_autoscaler" {
  description = "EKS autoscaling Policy"
  name        = "${var.cluster_name}-${local.tag_environment}-autoscaler"
  policy      = data.aws_iam_policy_document.eks_autoscaling_policy.json
}

resource "aws_iam_role_policy_attachment" "worker_autoscaling_policy" {
  role       = aws_iam_role.worker.name
  policy_arn = aws_iam_policy.eks_autoscaler.arn
}

resource "aws_iam_role_policy_attachment" "worker_kms_policy" {
  role       = aws_iam_role.worker.name
  policy_arn = aws_iam_policy.eks_cluster_kms_permissions.arn
}
