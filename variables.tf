variable "alarm_actions" {
  default     = []
  description = "The actions to execute when this alarm transitions to the ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN)"
  type        = "list"
}

variable "bounds" {
  default     = "Both"
  description = "The type of alarm threshold(s) to set. Either AlarmHigh, AlarmLow or Both. Defaults to Both."
  type        = "string"
}

variable "datapoints_to_alarm" {
  description = "The number of datapoints that must be breaching to trigger the alarm. This is used only if you are setting an M out of N alarm. In that case, this value is the M."
  type        = "string"
}

variable "dead_letter_arn" {
  description = "The arn for the SNS topic that handles dead letters"
  type        = "string"
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold. If you are setting an alarm that requires that a number of consecutive data points be breaching to trigger the alarm, this value specifies that number. If you are setting an M out of N alarm, this value is the N. An alarm's total current evaluation period can be no longer than one day, so this number multiplied by period cannot be more than 86,400 seconds."
  type        = "string"
}

variable "execution_schedule_expresssion" {
  default     = "rate(1 day)"
  description = "The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes)."
  type        = "string"
}

variable "insufficient_data_actions" {
  default     = []
  description = "The actions to execute when this alarm transitions to the INSUFFICIENT_DATA state from any other state. Each action is specified as an Amazon Resource Name (ARN)"
  type        = "list"
}

variable "kms_key_arn" {
  description = "The arn of the KMS key used to encrypt the environment variables"
  type        = "string"
}

variable "metric_dimensions" {
  default     = []
  description = "The dimensions for the metric specified in metric_name`. This is a list of dimension name and value pairs (seperated by commas) . The dimension values may be regular expressions. If not present, all metrics that match metric_namespace and metric_name will have alarms created for them."
  type        = "list"
}

variable "metric_name" {
  description = "The name for the metric associated with the alarm"
  type        = "string"
}

variable "metric_namespace" {
  description = "The namespace for the metric associated with the alarm"
  type        = "string"
}

variable "metric_sample_days" {
  default     = 15
  description = "The number of days to use to calculate the mean and population standard deviation from. Must be less than 455."
  type        = "string"
}

variable "metric_stat" {
  description = "The statistic to use for the metric. It can include any CloudWatch statistic"
  type        = "string"
}

variable "metric_unit" {
  description = "The unit to use for the metric data points"
  type        = "string"
}

variable "num_standard_deviation" {
  default     = 3
  description = "The number of standard deviations used to caluculate high/low thresholds"
  type        = "string"
}

variable "ok_actions" {
  default     = []
  description = "The actions to execute when this alarm transitions to an OK state from any other state. Each action is specified as an Amazon Resource Name (ARN)"
  type        = "list"
}

variable "period" {
  description = "The length, in seconds, used each time the metric specified in metric_name is evaluated. Valid values are 10, 30, and any multiple of 60. An alarm's total current evaluation period can be no longer than one day, so this multiplied by evaluation_periods cannot be more than 86,400 seconds. The actual period used may be changed by metric_sample_days as CloudWatch places certain requirements of period length when retrieving metric data."
  type        = "string"
}
