output "alb_dns_name" {
  description = "Public DNS name of the ALB (the app URL)."
  value       = aws_lb.this.dns_name
}

output "alb_arn" {
  description = "ARN of the ALB."
  value       = aws_lb.this.arn
}

output "target_group_arn" {
  description = "ARN of the ALB target group."
  value       = aws_lb_target_group.this.arn
}

output "alb_arn_suffix" {
  description = "ALB ARN suffix (for CloudWatch dimensions)."
  value       = aws_lb.this.arn_suffix
}

output "target_group_arn_suffix" {
  description = "Target group ARN suffix (for CloudWatch dimensions)."
  value       = aws_lb_target_group.this.arn_suffix
}

output "asg_name" {
  description = "Name of the Auto Scaling Group."
  value       = aws_autoscaling_group.this.name
}
