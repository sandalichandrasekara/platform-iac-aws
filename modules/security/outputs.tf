output "alb_sg_id" {
  description = "Security group ID for the ALB."
  value       = aws_security_group.alb.id
}

output "app_sg_id" {
  description = "Security group ID for the app tier (EC2)."
  value       = aws_security_group.app.id
}

output "data_sg_id" {
  description = "Security group ID for the data tier (DocumentDB)."
  value       = aws_security_group.data.id
}

output "instance_profile_name" {
  description = "IAM instance profile for EC2 (grants SSM access)."
  value       = aws_iam_instance_profile.app.name
}

output "app_role_arn" {
  description = "ARN of the EC2 IAM role."
  value       = aws_iam_role.app.arn
}
