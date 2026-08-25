variable "name_prefix" {
  description = "Prefix for names/tags, e.g. \"platform-dev\"."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID (for the ALB target group)."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the ALB."
  type        = list(string)
}

variable "app_subnet_ids" {
  description = "Private app subnet IDs for the Auto Scaling Group."
  type        = list(string)
}

variable "alb_sg_id" {
  description = "Security group ID for the ALB."
  type        = string
}

variable "app_sg_id" {
  description = "Security group ID for the EC2 instances."
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile granting SSM access."
  type        = string
}

variable "app_port" {
  description = "Port the application listens on."
  type        = number
  default     = 8080
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "Minimum ASG size."
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum ASG size."
  type        = number
  default     = 4
}

variable "desired_capacity" {
  description = "Desired ASG size."
  type        = number
  default     = 2
}

variable "health_check_path" {
  description = "HTTP path the ALB uses for health checks."
  type        = string
  default     = "/"
}

variable "certificate_arn" {
  description = "ACM certificate ARN. If set, the ALB serves HTTPS and redirects HTTP to it. If empty, plain HTTP only."
  type        = string
  default     = ""
}

variable "user_data" {
  description = "Optional user-data script. If empty, a minimal placeholder web server is started so health checks pass."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Extra tags applied to all resources."
  type        = map(string)
  default     = {}
}
