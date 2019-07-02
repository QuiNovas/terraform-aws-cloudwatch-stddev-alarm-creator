data "aws_iam_policy_document" "creator" {
  statement {
    actions = [
      "cloudwatch:DeleteAlarms",
      "cloudwatch:GetMetricData",
      "cloudwatch:ListMetrics",
      "cloudwatch:PutMetricAlarm",
    ]
    resources = [
      "*",
    ]
    sid = "AllowReadingMetricsAndManagingAlarms"
  }
}

