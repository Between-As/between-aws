data "aws_iam_policy_document" "cloudwatch_grafana_policy_document" {
  statement {
    actions = [
			"cloudwatch:DescribeAlarmsForMetric",
      "cloudwatch:DescribeAlarmHistory",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:ListMetrics",
      "cloudwatch:GetMetricData",
      "cloudwatch:GetInsightRuleReport"
    ]

    resources = [
      "*"
    ]

    effect = "Allow"
  }
}

resource "aws_iam_policy" "cloudwatch_grafana_policy" {
  name        = "${var.cluster_name}-cloudwatch-grafana-policy"
  description = "CloudWatch and Grafana integration policy"
  policy      = data.aws_iam_policy_document.cloudwatch_grafana_policy_document.json

  tags = var.common_tags
}

resource "aws_iam_role_policy_attachment" "cloudwatch_grafana_policy_attachment" {
  role       = var.grafana_service_role
  policy_arn = aws_iam_policy.cloudwatch_grafana_policy.arn
}