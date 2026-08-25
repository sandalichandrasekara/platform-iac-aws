variable "name_prefix" {
  description = "Prefix for names/tags, e.g. \"platform-dev\"."
  type        = string
}

variable "subnet_ids" {
  description = "Private data subnet IDs for the DocumentDB subnet group."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups attached to the cluster (the data-tier SG)."
  type        = list(string)
}

variable "master_username" {
  description = "Master username for DocumentDB."
  type        = string
  default     = "appadmin"
}

variable "instance_class" {
  description = "Instance class for DocumentDB instances."
  type        = string
  default     = "db.t3.medium"
}

variable "instance_count" {
  description = "Number of DocumentDB instances (1 = single, 2+ = HA)."
  type        = number
  default     = 1
}

variable "port" {
  description = "DocumentDB port."
  type        = number
  default     = 27017
}

variable "parameter_group_family" {
  description = "DocumentDB parameter group family (matches the engine version)."
  type        = string
  default     = "docdb5.0"
}

variable "kms_key_id" {
  description = "KMS key ARN for storage encryption. Null uses the AWS-managed key."
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "Protect the cluster from accidental deletion."
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip the final snapshot on destroy. Keep false outside throwaway envs."
  type        = bool
  default     = false
}

variable "backup_retention_days" {
  description = "Days DocumentDB retains automated backups."
  type        = number
  default     = 7
}

variable "preferred_backup_window" {
  description = "Daily time range (UTC) for automated backups."
  type        = string
  default     = "03:00-04:00"
}

variable "secret_recovery_window_days" {
  description = "Days before a deleted credentials secret is permanently removed."
  type        = number
  default     = 7
}

variable "tags" {
  description = "Extra tags applied to all resources."
  type        = map(string)
  default     = {}
}
