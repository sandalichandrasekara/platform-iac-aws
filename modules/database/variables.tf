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

variable "tags" {
  description = "Extra tags applied to all resources."
  type        = map(string)
  default     = {}
}
