data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "codebuild_iam_role_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    principals {
      type        = "AWS"
      identifiers = [var.eks_role_name]
    }
  }
}

data "aws_iam_policy_document" "codebuild_iam_policy" {
  statement {
    sid = "CodeBuildGeneralPermissions"

    actions = [
        "codebuild:CreateReportGroup",
        "codebuild:CreateReport",
        "codebuild:UpdateReport",
        "codebuild:BatchPutCodeCoverages",
        "codebuild:BatchPutTestCases",
        "ssm:GetParameters"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "ECRPermissions"

    actions = [
        "ecr:*",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "EKSPermissions"

    actions = [
        "eks:DescribeCluster",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "S3Permissions"

    actions = [
        "s3:PutObject",
        "s3:GetObject",
        "s3:GetBucketAcl",
        "s3:GetBucketLocation",
        "s3:GetObjectVersion"
    ]

    resources = [
        "arn:aws:s3:::codepipeline-${var.aws_region}-*",
        "arn:aws:s3:::staging-codepipeline-${var.aws_region}-*"
    ]
  }

  statement {
    sid = "CloudwatchLogsPermissions"

    actions = [
        "logs:CreateLogStream",
        "logs:CreateLogGroup",
        "logs:PutLogEvents",
    ]

    resources = [
        "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/*",
        "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/*:*",
    ]
  }

  statement {
    sid = "EC2Permissions"

    actions = [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeDhcpOptions",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "EC2InterfacePermissions"

    actions = [
        "ec2:CreateNetworkInterfacePermission"
    ]

    resources = [
        "arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:network-interface/*",
    ]
    
    condition {
      test     = "StringEquals"
      variable = "ec2:AuthorizedService"

      values = [
        "codebuild.amazonaws.com"
      ]
    }

    condition {
      test     = "ArnEquals"
      variable = "ec2:Subnet"

      values = local.subnet_arns_list
    }
  }
}
