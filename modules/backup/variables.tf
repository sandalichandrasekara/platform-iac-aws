variable "name_prefix" {
  description = "Prefix for names/tags, e.g. \"platform-dev\"."
  type        = string
}

variable "resource_arns" {
  description = "ARNs of resources to back up (e.g. the DocumentDB cluster)."
  type        = list(string)
}

variable "schedule" {
  description = "Backup schedule as a cron expression (UTC)."
  type        = string
  default     = "cron(0 5 * * ? *)" # daily at 05:00 UTC
}

variable "retention_days" {
  description = "Number of days to keep each recovery point."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Extra tags applied to all resources."
  type        = map(string)
  default     = {}
}
