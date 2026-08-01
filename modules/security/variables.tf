variable "name_prefix" {
  description = "Prefix for names/tags, e.g. \"platform-dev\"."
  type        = string
}

variable "vpc_id" {
  description = "VPC the security groups belong to."
  type        = string
}

variable "app_port" {
  description = "Port the application listens on (ALB forwards here)."
  type        = number
  default     = 8080
}

variable "alb_ingress_cidrs" {
  description = "CIDRs allowed to reach the ALB (HTTP/HTTPS)."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "db_port" {
  description = "DocumentDB port."
  type        = number
  default     = 27017
}

variable "tags" {
  description = "Extra tags applied to all resources."
  type        = map(string)
  default     = {}
}
