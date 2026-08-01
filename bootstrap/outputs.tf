output "state_bucket_name" {
  description = "Name of the S3 bucket that stores Terraform state. Use this in each environment's backend config."
  value       = aws_s3_bucket.state.id
}

output "region" {
  description = "Region the state bucket lives in."
  value       = var.region
}
