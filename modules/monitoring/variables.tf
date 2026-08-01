variable "name_prefix" {
  description = "Prefix for names/tags, e.g. \"platform-dev\"."
  type        = string
}

variable "asg_name" {
  description = "Auto Scaling Group name to monitor CPU on."
  type        = string
}

variable "alb_arn_suffix" {
  description = "ALB ARN suffix (for CloudWatch dimensions)."
  type        = string
}

variable "target_group_arn_suffix" {
  description = "Target group ARN suffix (for CloudWatch dimensions)."
  type        = string
}

variable "alarm_email" {
  description = "Email to receive alarm notifications. Leave empty to skip subscription."
  type        = string
  default     = ""
}

variable "cpu_threshold" {
  description = "CPU % that triggers the high-CPU alarm."
  type        = number
  default     = 80
}

variable "tags" {
  description = "Extra tags applied to all resources."
  type        = map(string)
  default     = {}
}
