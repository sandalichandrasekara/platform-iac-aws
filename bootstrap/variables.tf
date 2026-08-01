variable "region" {
  description = "AWS region for the state bucket."
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_name" {
  description = "Globally unique name for the S3 bucket that stores Terraform state."
  type        = string
  default     = "platform-iac-aws-tfstate"
}
