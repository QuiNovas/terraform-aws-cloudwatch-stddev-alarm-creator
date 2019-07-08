resource "random_string" "name_suffix" {
  length  = 16
  special = false
}

resource "aws_iam_policy" "creator" {
  name   = "LambdaLambdaLambdaCloudwatchStddevAlarmCreator-${random_string.name_suffix.result}"
  policy = data.aws_iam_policy_document.creator.json
}

module "creator" {
  dead_letter_arn = var.dead_letter_arn
  environment_variables = {
    ALARM_ACTIONS             = join(",", var.alarm_actions)
    ALARM_NAME                = var.alarm_name
    BOUNDS                    = var.bounds
    DATAPOINTS_TO_ALARM       = var.datapoints_to_alarm
    EVALUATION_PERIODS        = var.evaluation_periods
    INSUFFICIENT_DATA_ACTIONS = join(",", var.insufficient_data_actions)
    METRIC_DIMENSIONS         = join(";", var.metric_dimensions)
    METRIC_NAME               = var.metric_name
    METRIC_NAMESPACE          = var.metric_namespace
    METRIC_SAMPLE_DAYS        = var.metric_sample_days
    METRIC_STAT               = var.metric_stat
    METRIC_UNIT               = var.metric_unit
    NUM_STANDARD_DEVIATION    = var.num_standard_deviation
    OK_ACTIONS                = join(",", var.ok_actions)
    PERIOD                    = var.period
    TREAT_MISSING_DATA        = var.treat_missing_data
  }
  handler     = "function.handler"
  kms_key_arn = var.kms_key_arn
  name        = local.creator_name
  policy_arns = [
    aws_iam_policy.creator.arn,
  ]
  runtime           = "python3.7"
  l3_object_key     = "quinovas/cloudwatch-stddev-alarm-creator/cloudwatch-stddev-alarm-creator-0.0.2.zip"
  source            = "QuiNovas/lambdalambdalambda/aws"
  timeout           = 900
  version           = "3.0.1"
}

resource "aws_cloudwatch_event_rule" "creator" {
  description         = "Scheduled event that initiates alarm creation"
  is_enabled          = true
  name                = local.creator_name
  schedule_expression = var.execution_schedule_expresssion
}

resource "aws_lambda_permission" "creator" {
  action        = "lambda:InvokeFunction"
  function_name = module.creator.name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.creator.arn
  statement_id  = "${module.creator.name}-execution-permission"
}

resource "aws_cloudwatch_event_target" "creator" {
  arn        = module.creator.arn
  depends_on = [aws_lambda_permission.creator]
  rule       = aws_cloudwatch_event_rule.creator.name
}

