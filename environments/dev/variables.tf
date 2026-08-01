variable "project" {
  description = "Project name, used in resource names/tags."
  type        = string
  default     = "platform"
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region."
  type        = string
  default     = "us-east-1"
}

variable "alarm_email" {
  description = "Email for CloudWatch alarm notifications. Leave empty to skip."
  type        = string
  default     = ""
}
