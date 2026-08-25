output "app_url" {
  description = "Public URL of the application (ALB DNS name)."
  value       = "http://${module.compute.alb_dns_name}"
}

output "db_endpoint" {
  description = "DocumentDB writer endpoint."
  value       = module.database.endpoint
}

output "db_secret_arn" {
  description = "Secrets Manager ARN holding DB credentials."
  value       = module.database.secret_arn
}
