output "sns_topic_arn" {
  description = "ARN of the SNS alerts topic."
  value       = aws_sns_topic.alerts.arn
}

output "alarm_names" {
  description = "Names of the CloudWatch alarms."
  value = [
    aws_cloudwatch_metric_alarm.cpu_high.alarm_name,
    aws_cloudwatch_metric_alarm.unhealthy_hosts.alarm_name,
    aws_cloudwatch_metric_alarm.target_5xx.alarm_name,
  ]
}
